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
  default = "ubuntu-20.04-server-latest"
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
    "centos-7-1805"               = "f5587dca-3011-4d53-a912-b55445d04a33",
    "centos-8-elx-latest"         = "30eb25f7-0b25-4038-b044-17c4a4036f97",
    "centos-9-elx-latest"         = "87a88e31-1a4b-44d3-b855-edea08903b96",
    "centos-atomic-7-1805"        = "735d87ac-e057-48e4-bd58-f4d74dc0e04d",
    "cirros-0.5.1"                = "1525aeac-1a8e-4696-b715-f8f9ffa8f0b9",
    "debian-10-latest"            = "fc316521-5327-4252-bf4f-923ec4f0d372",
    "debian-11-latest"            = "6bc0379d-36aa-4ad8-9381-15acedf20693",
    "rocky-8-elx-latest"          = "e173724d-bdff-4c9e-9a46-a6e7e622853e",
    "ubuntu-18.04-server-latest"  = "139fca84-cf03-4fb5-8d20-b0c79f00ada9",
    "ubuntu-20.04-server-latest"  = "ad20f881-7095-42d5-a438-a980e7d0c78f",
    "ubuntu-22.04-server-latest"  = "4efe3a41-f434-4079-85ca-e10f3f1915d1",
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
    "v1-c1-m0.5-d20"      = "38f1adc0-5637-4391-903b-798388554628",
    "v1-c1-m1-d20"        = "c53c4a7c-a579-4a72-9bfd-f9b4bd474dd5",
    "v1-c1-m2-d20"        = "07905559-28c3-41f2-b6a8-90ec6c21bd25",
    "v1-c1-m4-d40"        = "543ed29e-dc24-4c6a-b122-0279d8ee6fb1",
    "v1-c1-m8-d60"        = "35b4310b-6258-49f5-8cc2-27ee993a67a9",
    "v1-c2-m16-d120"      = "a2a43747-57b5-444c-8f51-c214104db339",
    "v1-c2-m4-d60"        = "6b576115-1e0d-4f8e-bc3a-8d45732a44b5",
    "v1-c2-m8-d80"        = "64fb665a-4c02-4cba-aeed-2bf2d28dae60",
    "v1-c4-m16-d160"      = "2f2c8943-c244-439c-b022-e4aff6c68131",
    "v1-c4-m32-d240"      = "4619f140-3b3e-4e17-9260-7751a68dbe82",
    "v1-c4-m8-d120"       = "150ac931-0b69-44df-b165-aabd15b3bc8a",
    "v1-c8-m16-d240"      = "77a561fb-f002-4a0f-a596-908737fd7e9f",
    "v1-c8-m32-d320"      = "d8c39704-6596-4837-9a17-6936f663d171",
    "v1-c8-m64-d480"      = "4e42da2a-b591-4d65-ae79-c531b8fcbbf8",
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