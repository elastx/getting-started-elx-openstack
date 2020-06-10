output "subnet_id" {
  value = openstack_networking_subnet_v2.subnet.id
}
output "subnet_name" {
  value = openstack_networking_subnet_v2.subnet.name
}
output "network_id" {
  value = openstack_networking_network_v2.network.id
}
output "network_name" {
  value = openstack_networking_network_v2.network.name
}
output "bastion_servers_ansible" {
  value = "[bastion_servers]\n${join("\n", [for key, bastion in openstack_networking_floatingip_v2.bastion : "${key} ansible_ssh_host=${bastion.address}"])}"
}
output "bastion_servers_map" {
  value = zipmap(keys(openstack_networking_floatingip_v2.bastion), values(openstack_networking_floatingip_v2.bastion)[*].address)
}
output "bastion_secgroup_name" {
  value = openstack_networking_secgroup_v2.bastion.name
}
output "bastion_secgroup_id" {
  value = openstack_networking_secgroup_v2.bastion.id
}
