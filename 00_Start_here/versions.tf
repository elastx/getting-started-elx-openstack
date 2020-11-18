terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.28"
    }
  }
  required_version = ">= 0.13"
}
