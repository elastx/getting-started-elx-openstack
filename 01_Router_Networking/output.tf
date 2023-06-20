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

