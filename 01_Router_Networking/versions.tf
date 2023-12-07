terraform {
  required_providers {
    openstack = {
      source  = "registry.terraform.io/terraform-provider-openstack/openstack"
      version = "~> 1.45"
    }
    null      = {
      source  = "registry.terraform.io/hashicorp/null"
      version = "~> 3.1"
    }
  }
  required_version = ">= 1.6.3"
}
