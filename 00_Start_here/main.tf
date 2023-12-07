terraform {
  backend "s3" {
    bucket                        = "terraform-state"
    key                           = "gs-keypair/terraform.tfstate"
    endpoints                     = {
    s3 = "https://swift.elastx.cloud/"
    }
    skip_s3_checksum              = "true"
    region                        = "us-east-1"
    use_path_style                = "true"
    skip_credentials_validation   = "true"
    skip_requesting_account_id    = "true"
    skip_metadata_api_check       = "true"
  }
}

resource "openstack_compute_keypair_v2" "keypair" {
  name  = var.keypair_name
}

