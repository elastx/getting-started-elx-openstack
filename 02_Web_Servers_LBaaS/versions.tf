terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.28"
    }
  }
  required_version = ">= 0.13"
}
