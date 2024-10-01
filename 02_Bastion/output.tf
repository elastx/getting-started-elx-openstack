output "bastion_servers_ansible" {
  value = "[bastion_servers]\n${join("\n", [for key, bastion in openstack_networking_floatingip_v2.bastion_fip : "${key} ansible_ssh_host=${bastion.address}"])}"
}
output "bastion_servers_map" {
  value = zipmap(keys(openstack_networking_floatingip_v2.bastion_fip), values(openstack_networking_floatingip_v2.bastion_fip)[*].address)
}
output "bastion_secgroup_name" {
  value = openstack_networking_secgroup_v2.bastion.name
}
output "bastion_secgroup_id" {
  value = openstack_networking_secgroup_v2.bastion.id
}
