keypair_name = "demo-gs-elastx"

ssh_trusted_endpoints = {
  world = "0.0.0.0/0"
}

subnet_cidr = "10.0.65.0/24"

flavor = "v1-c2-m8-d80"
image  = "ubuntu-20.04"

// We strongly advise to use image_id's. A name can get a new ID which forces
// Terraform to recreate the compute instance(s). Especially images having the
// "latest" suffix. Here's an example how to map a custom name to an ID.

// For a full list of available public images you can use the command 
// "openstack image list". Images with "latest" suffix are renamed but can be
// referred to by id. All these images can be found using command
// "openstack image list --community"
images = {
  "ubuntu-20.04" = "ad20f881-7095-42d5-a438-a980e7d0c78f",
  "ubuntu-22.04" = "4efe3a41-f434-4079-85ca-e10f3f1915d1",
}

bastion_hosts = {
  "bastion-sto1-srv1" = { "az" = "sto1" },
}
