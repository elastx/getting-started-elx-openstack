variable "keypair" {
  type        = map(any)
  default     = {}
  description = <<DESCRIPTION

  A map with a key (name of resource) and value (path to public key) (optional)

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
variable "bastion_hosts" {
  type    = map(any)
  default = {}
}
variable "image" {
  # Used as default if not specified from example.auto.tfvars
  type    = string
  default = "ubuntu-24.04-server-latest"
}
# We strongly advise to use image_id's. A name can get a new ID which forces
# Terraform to recreate the compute instance(s). Especially images having the
# "latest" suffix. Here's an example how to map a custom name to an ID

# For a full list of available public images you can use the command 
# "openstack image list". Images with "latest" suffix are renamed but can be
# referred to by id. All these images can be found using command
# "openstack image list --community"
variable "images" {
  type = map(any)
  default = {
    "centos-8-elx-latest"         = "e3d92553-68af-4e58-8c01-b7beb12dc6f9",
    "centos-9-elx-latest"         = "91ea2be5-fe86-498b-bf2c-d80df31ffccc",
    "cirros-0.5.1"                = "1525aeac-1a8e-4696-b715-f8f9ffa8f0b9",
    "debian-11-latest"            = "02f89e5f-2402-43b5-ad7b-c6edadbff1ea",
    "debian-12-latest"            = "c54208fd-80bd-464f-af6f-0c90f5a5620e",
    "rocky-8-elx-latest"          = "5eeb14e4-deb0-4149-bb5a-b3235b04a82f",
    "ubuntu-20.04-server-latest"  = "d7bb5f69-cdc1-4a17-b2c3-340ca429b6a1",
    "ubuntu-22.04-server-latest"  = "e2590b0d-8723-4ca7-88b8-8249ca0ef1af",
    "ubuntu-24.04-server-latest"  = "d7722538-cb6f-4a36-8dcf-36e92aa8d34a",
  }
}
variable "flavor" {
  # Used as default if not specified in example.auto.tfvars
  type    = string
  default = "v1-c2-m8-d80"
}
variable "flavors" {
  type = map(any)
  default = {
    "v2-c1-m0.5-d20"      = "9044311a-8f8d-4b41-b62d-e9e3bcdb1a21",
    "v2-c1-m1-d20"        = "8e927902-8365-47f9-bd96-edc14668d289",
    "v2-c1-m2-d20"        = "15b9f196-27a9-4d49-9f81-b1c03bc5db3c",
    "v2-c1-m4-d40"        = "9369426e-45c3-4929-b712-9a6f7358accd",
    "v2-c1-m8-d60"        = "6590aa67-51c8-428f-a7ef-634f77203712",
    "v2-c2-m1-d20"        = "399a82e5-84ba-4656-aee1-f0f7a4a356e8",
    "v2-c2-m16-d120"      = "f483d6a1-2a2b-4050-8e6a-2b69014e8a28",
    "v2-c2-m2-d20"        = "8acbb825-7616-40ca-bb39-f1a64c4e8aa9",
    "v2-c2-m4-d60"        = "37bb6433-c0e7-4702-b416-f98a2cf6d11b",
    "v2-c2-m8-d80"        = "457bb2c3-554e-4d1b-b3d2-94fa022e8614",
    "v2-c4-m16-d160"      = "60002ff6-980e-4424-b125-e9b6794043e9",
    "v2-c4-m32-d240"      = "bc3e0b87-75f1-41a7-9c8c-db9d3d75bbc0",
    "v2-c4-m8-d120"       = "4e4318bb-8cd9-4274-8150-4eaeb478b8e5",
    "v2-c8-m16-d240"      = "19015e26-f941-49e0-b826-b44fadc00254",
    "v2-c8-m32-d320"      = "bba30882-67b1-42fc-a396-f5dd9211e792",
    "v2-c8-m64-d480"      = "b5976032-0512-4f53-a659-cbe9597f8fc5",
    "d2-c8-m120-d1.6k"    = "515e5177-8a3b-4153-a664-ff1dddc97b42",
    "d3-c24-m240-d3.2k"   = "d83df7fa-156a-461e-a013-3bd19f44606e",
  }
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
