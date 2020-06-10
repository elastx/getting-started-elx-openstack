// Refer to 01_Router_Networking_Bastion.tfvars on which host to use in order
// pass through access to web servers
bastion_host           = "bastion-sto1-srv1"
bastion_security_group = "bastion"
keypair_name           = "gs-elastx"

flavor = "v1-standard-1"

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

// Then point out the default image to use in which you can override in the
// per server definition in the web_hosts map down below
image = "ubuntu-20.04"

user_data = <<DATA
#cloud-config
package_update: true
package_upgrade: true
packages:
  - python3-minimal
  - apache2
  - jq
runcmd:
  - curl -s http://169.254.169.254/latest/meta-data/hostname >/var/www/html/index.html
  - echo >>/var/www/html/index.html 
  - curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone >>/var/www/html/index.html
  - echo >>/var/www/html/index.html 
  - echo >>/var/www/html/index.html
  - echo "OK" >/var/www/html/health.html
final_message: "ELX - The system is finally up, after $UPTIME seconds"
DATA

/*****************************************************************************
 * A map of web hosts, AZ placement, image, flavor and user_data         *
 ****************************************************************************/

// web_hosts = {
//  "server_name_1" = {
//    "az"        = "Availability Zone sto1, sto2 or sto3 (REQUIRED)",
//    "flavor"    = "flavor name (OPTIONAL)",
//    "image"     = "image name (OPTIONAL)",
//    "user_data" = "cloud-init (OPTIONAL)",
//  },
// }

web_hosts = {
  "web-sto1-srv1" = { "az" = "sto1" },
  "web-sto2-srv1" = { "az" = "sto2" },
  "web-sto3-srv1" = { "az" = "sto3" }
}

lb_name = "web-se-sto-lb1"
