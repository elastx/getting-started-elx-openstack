keypair_name = "demo-gs-elastx"

ssh_trusted_endpoints = {
  world = "0.0.0.0/0"
}
#Here you can configure what ip addresses should be allowed to your bastion host.
# If you for example want to only allow your own external ip address,
# add it in combination the CIDR notation /32 (e.g. 1.2.3.4/32).
# The default "0.0.0.0/0" is setting up a rule that says:
# "Allow anyone in the world to attempt to connect to our system using SSH".
# Please be aware that from a security perspective,
# this is generally not advisable unless you have additional measures in place to restrict and secure these connections,
# as it opens up the system to SSH connection attempts from any IP address in the world. 
flavor = "v2-c2-m8-d80"
# We strongly advise to use image_id's. 
# A name can get a new ID which forces Terraform to recreate the compute instance(s). 
# Especially images having the "latest" suffix. 
# To make the configuration files more readable we show in this demo 
# how to make a list to map names to specific IDs.
# The list of mappings is located in variables.tf
image  = "ubuntu-24.04-server-latest"

bastion_hosts = {
  "bastion-sto1-srv1" = { "az" = "sto1" },
}
