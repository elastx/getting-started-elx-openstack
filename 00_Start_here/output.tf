output "keypair_name" {
  value = openstack_compute_keypair_v2.keypair.name
}
output "keypair_public_key" {
  value = openstack_compute_keypair_v2.keypair.public_key
}
output "keypair_private_key" {
  value = openstack_compute_keypair_v2.keypair.private_key
}
