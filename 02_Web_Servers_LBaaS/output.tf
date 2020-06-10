output "web_servers_ansible" {
  value = "[web_servers]\n${join("\n", [for key, web in openstack_compute_instance_v2.web : "${key} ansible_ssh_host=${web.access_ip_v4}"])}"
}
output "loadbalancer_ip" {
  value = openstack_networking_floatingip_v2.web_lb_fip.address
}
