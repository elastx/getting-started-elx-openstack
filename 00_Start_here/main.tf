terraform {
  backend "swift" {
    container         = "terraform-state-start"
    archive_container = "terraform-state-archive-start"
  }
}

resource "openstack_compute_keypair_v2" "keypair" {
  name = var.keypair_name
}
