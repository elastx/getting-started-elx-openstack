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
  type    = string
  default = "ubuntu-18.04-server-latest"
}
variable "bastion_hosts" {
  type    = map(any)
  default = {}
}
variable "images" {
  type = map(any)
  default = {
    "centos-6-1907"                = "a03d54ca-35b1-4724-9f6b-3288da1e8cba",
    "centos-7-1805"                = "f5587dca-3011-4d53-a912-b55445d04a33",
    "centos-7-elx-latest"          = "ed0c6b36-8706-45a6-9b78-665b8a4f85d0",
    "centos-8-elx-latest"          = "8ad39f59-a2fe-44f5-a7a0-edce6a865f6c",
    "centos-atomic-7-1805"         = "735d87ac-e057-48e4-bd58-f4d74dc0e04d",
    "debian-10-latest"             = "fdf6148d-2464-40b1-bd7e-79fa1b0c7880",
    "debian-8-latest"              = "2bc467c4-281c-4ea6-9d50-c36bf59d91e2",
    "debian-9-latest"              = "e237a90f-4ae9-44c6-a434-f52e443aa2fa",
    "ubuntu-14.04-server-latest"   = "5b8236af-5b31-49d1-8155-b550a55acd3f",
    "ubuntu-16.04-server-20180912" = "9c61aa37-a553-4753-9c64-b6069aec4dd5",
    "ubuntu-16.04-server-latest"   = "62d4f86b-b4a2-4d06-b2d6-fa3f081927f9",
    "ubuntu-18.04-server-20180911" = "f9cf1781-1ee0-4a2e-8625-b9d6c09d04c7",
    "ubuntu-18.04-server-20200101" = "f1d2202f-3b60-445d-a5f2-268bdaf2f506",
    "ubuntu-18.04-server-latest"   = "4137d47a-59a7-455b-95e4-75ae2713067a",
    "ubuntu-20.04-server-latest"   = "aa49758b-3344-4aea-949e-e3fd884d33d7",
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
  }
}
variable "flavor" {
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