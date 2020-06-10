keypair_name = "gs-elastx"

ssh_trusted_endpoints = {
  world = "0.0.0.0/0"
}

subnet_cidr = "10.0.65.0/24"

flavor = "v1-standard-2"
image  = "ubuntu-20.04"

// We strongly advise to use image_id's. A name can get a new ID which forces
// Terraform to recreate the compute instance(s). Especially images having the
// "latest" suffix. Here's an example how to map a custom name to an ID.

// For a full list of available public images you can use the command 
// "openstack image list". Images with "latest" suffix are renamed but can be
// referred to by id. All these images can be found using command
// "openstack image list --community"
images = {
  "ubuntu-18.04" = "4137d47a-59a7-455b-95e4-75ae2713067a",
  "ubuntu-20.04" = "aa49758b-3344-4aea-949e-e3fd884d33d7",
}

bastion_hosts = {
  "bastion-sto1-srv1" = { "az" = "sto1" },
}
