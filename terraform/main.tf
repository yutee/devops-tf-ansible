# provision a virtual network from the network module
module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = "server-vnet"
  subnet_name         = "server-subnet"
  nsg_name            = "server-nsg"
  allowed_ports       = ["22", "80", "443"]
}

# provision a virtual machine instance from vm module
module "vm" {
  source              = "./modules/vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  vm_name             = "server"
  vm_size             = "Standard_B2s"
  admin_username      = var.admin_username
  ssh_public_key      = file(var.ssh_key_path)
  subnet_id           = module.network.subnet_id
}

# dynamically create an inventory file for ansible
resource "local_file" "inventory" {
  content = <<EOT
[servers]
${module.vm.public_ip} ansible_user=${var.admin_username} ansible_ssh_private_key_file=~/.ssh/id_rsa
EOT

  filename = "../ansible/inventory.ini"
}

# trigger the vm configuration with ansible
resource "null_resource" "ansible_provisioner" {
  depends_on = [
    local_file.inventory,
    module.vm,
    module.network
  ]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      sleep 60 # allow time for public ip to update
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
        -i ../ansible/inventory.ini \
        ../ansible/playbook.yml
    EOT
  }
}