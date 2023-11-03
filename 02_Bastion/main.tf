terraform {
  backend "s3" {
    bucket                        = "terraform-state"
    key                           = "gs-bastion/terraform.tfstate"
    endpoints                     = {
    s3 = "https://swift.elastx.cloud"
    }
    skip_s3_checksum              = "true"
    region                        = "us-east-1"
    use_path_style                = "true"
    skip_credentials_validation   = "true"
    skip_requesting_account_id    = "true"
  }
}

data "terraform_remote_state" "core" {
  backend = "s3"
  config = {
    bucket                        = "terraform-state"
    key                           = "gs-core/terraform.tfstate"
    endpoints                     = {
    s3 = "https://swift.elastx.cloud"
    }
    skip_s3_checksum              = "true"
    region                        = "us-east-1"
    use_path_style                = "true"
    skip_credentials_validation   = "true"
    skip_requesting_account_id    = "true"
  }
}

resource "openstack_compute_keypair_v2" "keypair" {
  for_each   = var.keypair
  name       = each.key
  public_key = file(each.value)
}

resource "openstack_networking_secgroup_v2" "bastion" {
  name        = "bastion"
  description = "Security group for bastion - Terraform managed"
}

resource "openstack_networking_secgroup_rule_v2" "bastions_trust" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_group_id   = openstack_networking_secgroup_v2.bastion.id
  security_group_id = openstack_networking_secgroup_v2.bastion.id
}

resource "openstack_networking_secgroup_rule_v2" "trusted_endpoints" {
  for_each          = var.ssh_trusted_endpoints
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = each.value
  security_group_id = openstack_networking_secgroup_v2.bastion.id
}

resource "openstack_compute_instance_v2" "bastion" {
  for_each          = var.bastion_hosts
  name              = each.key
  flavor_id         = lookup(var.flavors, lookup(each.value, "flavor", var.flavor))
  key_pair          = var.keypair_name
  security_groups   = [openstack_networking_secgroup_v2.bastion.name]
  availability_zone = each.value["az"]
  user_data         = lookup(each.value, "user_data", var.user_data)
  image_id          = lookup(var.images, lookup(each.value, "image", var.image))

  metadata = {
    "Image used" = lookup(each.value, "image", var.image)
    group        = "bastion"
  }

  network {
    uuid = data.terraform_remote_state.core.outputs.network_id
  }
}

resource "openstack_networking_floatingip_v2" "bastion" {
  for_each = var.bastion_hosts
  pool     = var.external_network
}

resource "openstack_compute_floatingip_associate_v2" "bastion_fip" {
  for_each    = var.bastion_hosts
  floating_ip = openstack_networking_floatingip_v2.bastion[each.key].address
  instance_id = openstack_compute_instance_v2.bastion[each.key].id
}

resource "null_resource" "waiter" {
  for_each = var.bastion_hosts

  triggers = {
    instance_ids = openstack_compute_instance_v2.bastion[each.key].id
  }

  provisioner "remote-exec" {
    connection {
      host  = openstack_networking_floatingip_v2.bastion[each.key].address
      type  = "ssh"
      agent = true
      user  = lookup(each.value, "ssh_user", var.ssh_user)
    }
    inline = [
      "while ! grep \"ELX - The system is finally up\" /var/log/cloud-init-output.log >/dev/null ; do echo \"waiting for cloud-init\"; sleep 2; done; echo \"cloud-init done!\"",
    ]
  }
}
