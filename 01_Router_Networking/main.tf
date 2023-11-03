terraform {
  backend "s3" {
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

resource "openstack_networking_router_v2" "router" {
  name                = var.router_name
  external_network_id = lookup(var.external_network_id, var.external_network)

resource "openstack_networking_network_v2" "network" {
  name = var.network_name
}

resource "openstack_networking_subnet_v2" "subnet" {
  name            = var.subnet_name
  network_id      = openstack_networking_network_v2.network.id
  cidr            = var.subnet_cidr
  ip_version      = 4
  enable_dhcp     = true
  dns_nameservers = var.subnet_dns
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}


