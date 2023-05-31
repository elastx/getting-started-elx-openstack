// Refer to 01_Router_Networking.tfvars on which host to use in order
// pass through access to web servers
bastion_host           = "bastion-sto1-srv1"
bastion_security_group = "bastion"
keypair_name           = "demo-gs-elastx"

// Specify the default flavor and image to use, these can be overwritten in the
// per server definition in the web_hosts map down below
flavor = "v1-c1-m4-d40"
// We strongly advise to use image_id's. 
// A name can get a new ID which forces Terraform to recreate the compute instance(s). 
// Especially images having the "latest" suffix. 
// To make the configuration files more readable we show in this demo 
// how to make a list to map names to specific IDs.
// The list of mappings is located in variables.tf
image = "ubuntu-20.04-server-latest"

// This cloud config example installs a set of packages 
// and fetches data from the Elastx meta-data server regarding 
// the respective instance's hostname and availability zone.
// It then feeds this information into our index.html file and is purely
// used for visual confirmation that our instance's ended up in different
// availability zones and that the load balancing is working as expected
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

