keypair_name = "demo-gs-elastx"

ssh_trusted_endpoints = {
  world = "0.0.0.0/0"
}

flavor = "v1-c2-m8-d80"
# We strongly advise to use image_id's. 
# A name can get a new ID which forces Terraform to recreate the compute instance(s). 
# Especially images having the "latest" suffix. 
# To make the configuration files more readable we show in this demo 
# how to make a list to map names to specific IDs.
# The list of mappings is located in variables.tf
image  = "ubuntu-20.04-server-latest"

bastion_hosts = {
  "bastion-sto1-srv1" = { "az" = "sto1" },
}
