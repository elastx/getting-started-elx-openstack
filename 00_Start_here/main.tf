terraform {
  backend "s3" {
    bucket                        = "terraform-state-archive"
    key                           = "gs-keypair/terraform.tfstate"
    endpoint                      = "https://swift.elastx.cloud"
    region                        = "us-east-1"
    force_path_style              = "true"
    skip_credentials_validation   = "true"
  }
}

resource "openstack_compute_keypair_v2" "keypair" {
  name  = var.keypair_name
}
