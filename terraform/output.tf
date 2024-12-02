# output the public ip of the vm
output "vm_public_ip" {
  value = module.vm.public_ip
}

# output the dns zone name
output "dns_zone_name" {
  value = data.azurerm_dns_zone.domain.name
}