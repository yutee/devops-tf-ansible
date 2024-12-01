# output the public ip of the vm
output "vm_public_ip" {
  value = module.vm.public_ip
}