terraform {
  required_providers {
    openstack = {
      source  = "registry.terraform.io/terraform-provider-openstack/openstack"
      version = "~> 3.0.0"
    }
    null = {
      source  = "registry.terraform.io/hashicorp/null"
      version = "~> 3.1"
    }
  }
  required_version = ">= 1.9.0"
}
