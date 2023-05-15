variable "keypair" {
  type        = map(any)
  default     = {}
  description = <<DESCRIPTION

  A map with a key (name of resource) and value (path to public key) (optinal)

  Example: { "bastion" = "~/.ssh/myproject.pub" }
DESCRIPTION
}
variable "keypair_name" {
  type        = string
  description = "Name of the key pair to be used for instances"
}
variable "ssh_trusted_endpoints" {
  type = map(any)
  default = {
    world = "0.0.0.0/0"
  }
  description = <<DESCRIPTION
  A map with a key (name of rule) and value (CIDR)

  Example: 
    { 
      vpn1  = "1.2.3.4/32",
      vpn2  = "5.6.7.8/32",
    }
DESCRIPTION
}
variable "external_network" { default = "elx-public1" }
variable "external_network_id" {
  type = map(any)
  default = {
    "elx-public1" = "600b8501-78cb-4155-9c9f-23dfcba88828",
  }
}
variable "router_name" {
  type    = string
  default = "core_router"
}
variable "network_name" {
  type    = string
  default = "core_network"
}
variable "subnet_name" {
  type    = string
  default = "core_subnet"
}
variable "subnet_cidr" {
  type    = string
  default = "10.0.64.0/24"
}
variable "subnet_dns" {
  type    = list(any)
  default = ["8.8.8.8", "8.8.4.4"]
}
variable "image" {
  # Used as default if not specified from example.auto.tfvars
  type    = string
  default = "ubuntu-20.04-server-latest"
}
variable "bastion_hosts" {
  type    = map(any)
  default = {}
}
variable "images" {
  type = map(any)
  default = {
    "centos-7-elx-latest"         = "f5587dca-3011-4d53-a912-b55445d04a33",
    "centos-8-elx-latest"         = "30eb25f7-0b25-4038-b044-17c4a4036f97",
    "centos-9-elx-latest"         = "87a88e31-1a4b-44d3-b855-edea08903b96",
    "centos-atomic-7-1805"        = "735d87ac-e057-48e4-bd58-f4d74dc0e04d",
    "debian-10-latest"            = "fc316521-5327-4252-bf4f-923ec4f0d372",
    "debian-11-latest"            = "6bc0379d-36aa-4ad8-9381-15acedf20693",
    "ubuntu-18.04-server-latest"  = "139fca84-cf03-4fb5-8d20-b0c79f00ada9",
    "ubuntu-20.04-server-latest"  = "ad20f881-7095-42d5-a438-a980e7d0c78f",
    "ubuntu-22.04-server-latest"  = "4efe3a41-f434-4079-85ca-e10f3f1915d1",
  }
}
variable "flavors" {
  type = map(any)
  default = {
    "v1-standard-4"  = "08857136-dd97-4014-afc2-b5a0bec6e07c",
    "v1-dedicated-8" = "0eea117d-28dd-4bd0-a386-18219004b3bd",
    "v1-standard-1"  = "28717ab2-8746-4a77-969d-04eecb61afcf",
    "v1-standard-2"  = "3f73fc93-ec61-4808-88df-2580d94c1a9b",
    "v1-mini-1"      = "7a6a998f-ac7f-4fb8-a534-2175b254f75e",
    "v1-small-1"     = "83d8b44a-26a0-4f02-a981-079446926445",
    "v1-micro-1"     = "bb856531-64ca-4045-9781-e5444112216e",
    "v2-dedicated-8" = "bfb3a0f7-6512-4553-ad83-66fb51108382",
    "v1-standard-8"  = "e25c6076-b2e5-4ce0-9144-6ea3422c1a54",
    "v1-c2-m8-d80"   = "64fb665a-4c02-4cba-aeed-2bf2d28dae60",
  }
}
variable "flavor" {
  # Used as default if not specified in example.auto.tfvars
  type    = string
  default = "v1-standard-2"
}
variable "user_data" {
  type    = string
  default = <<EOF
#cloud-config
final_message: "ELX - The system is finally up, after $UPTIME seconds"
EOF
}
variable "ssh_user" {
  type    = string
  default = "ubuntu"
}
