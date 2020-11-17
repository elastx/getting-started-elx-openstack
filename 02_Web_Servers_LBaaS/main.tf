provider "openstack" {
  use_octavia = true
}

terraform {
  backend "swift" {
    container         = "terraform-state-webservers"
    archive_container = "terraform-state-archive-webservers"
  }
}

data "terraform_remote_state" "core" {
  backend = "swift"
  config = {
    container         = "terraform-state-core"
    archive_container = "terraform-state-archive-core"
  }
}

resource "openstack_compute_servergroup_v2" "web_servergroup" {
  name     = "${terraform.workspace}-web_servergroup"
  policies = ["soft-anti-affinity"]
}


resource "openstack_compute_instance_v2" "web" {
  for_each          = var.web_hosts
  name              = "${terraform.workspace}-${each.key}"
  flavor_id         = lookup(var.flavors, lookup(each.value, "flavor", var.flavor))
  key_pair          = var.keypair_name
  security_groups   = [openstack_networking_secgroup_v2.lb_sg.name]
  availability_zone = each.value["az"]
  user_data         = lookup(each.value, "user_data", var.user_data)
  image_id          = lookup(var.images, lookup(each.value, "image", var.image))

  scheduler_hints {
    group = openstack_compute_servergroup_v2.web_servergroup.id
  }

  metadata = {
    "Image used" = var.image
    group        = "web"
  }

  network {
    uuid = data.terraform_remote_state.core.outputs.network_id
  }
}

resource "openstack_lb_loadbalancer_v2" "web_lb" {
  vip_subnet_id      = data.terraform_remote_state.core.outputs.subnet_id
  description        = "Terraform Managed"
  name               = "${terraform.workspace}-${var.lb_name}"
  security_group_ids = [openstack_networking_secgroup_v2.lb_sg.id]
}

resource "openstack_lb_listener_v2" "web_lb_listener" {
  protocol        = "HTTP"
  protocol_port   = 80
  loadbalancer_id = openstack_lb_loadbalancer_v2.web_lb.id

  insert_headers = {
    X-Forwarded-For = "true"
  }
}

resource "openstack_lb_pool_v2" "web_lb_pool" {
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.web_lb_listener.id
}

resource "openstack_lb_member_v2" "members" {
  for_each      = var.web_hosts
  address       = openstack_compute_instance_v2.web[each.key].access_ip_v4
  pool_id       = openstack_lb_pool_v2.web_lb_pool.id
  protocol_port = 80
}

resource "openstack_lb_monitor_v2" "web_lb_mon" {
  pool_id        = openstack_lb_pool_v2.web_lb_pool.id
  type           = "HTTP"
  delay          = 5
  timeout        = 5
  max_retries    = 3
  url_path       = "/health.html"
  expected_codes = "200"
}

resource "openstack_networking_floatingip_v2" "web_lb_fip" {
  pool = var.external_network
}

resource "openstack_networking_floatingip_associate_v2" "web_lb_fip" {
  floating_ip = openstack_networking_floatingip_v2.web_lb_fip.address
  port_id     = openstack_lb_loadbalancer_v2.web_lb.vip_port_id
}

resource "openstack_networking_secgroup_v2" "lb_sg" {
  name        = "${terraform.workspace}-web_lb_sg"
  description = "Security group for lb - Terraform managed"
}

resource "openstack_networking_secgroup_rule_v2" "lb_sg_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.lb_sg.id
}

resource "openstack_networking_secgroup_rule_v2" "bastion_sg_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_group_id   = data.terraform_remote_state.core.outputs.bastion_secgroup_id
  security_group_id = openstack_networking_secgroup_v2.lb_sg.id
}

resource "null_resource" "waiter" {
  for_each = var.web_hosts

  triggers = {
    instance_ids = openstack_compute_instance_v2.web[each.key].id
  }

  provisioner "remote-exec" {
    connection {
      bastion_host = data.terraform_remote_state.core.outputs.bastion_servers_map[var.bastion_host]
      host         = openstack_compute_instance_v2.web[each.key].access_ip_v4
      type         = "ssh"
      agent        = true
      user         = lookup(each.value, "ssh_user", var.ssh_user)
    }
    inline = [
      "while ! grep \"ELX - The system is finally up\" /var/log/cloud-init-output.log >/dev/null ; do echo \"waiting for cloud-init\"; sleep 2; done; echo \"cloud-init done!\"",
    ]
  }
}
