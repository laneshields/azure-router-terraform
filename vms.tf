resource "azurerm_linux_virtual_machine" "router1" {
    name = "router1"
    resource_group_name = var.azure_resource_group_name
    location = data.azurerm_resource_group.pre_defined.location
    size = var.t128_instance_size
    admin_username = var.t128_linux_admin_username

    tags = {
        node-name = var.node_name,
        router-name = var.router_name,
        conductor-ip-primary = var.conductor1_ip,
    }

    network_interface_ids = [
        azurerm_network_interface.router1_mgmt.id,
        azurerm_network_interface.router1_wan.id,
        azurerm_network_interface.router1_lan.id
    ]

    admin_ssh_key {
      username = var.t128_linux_admin_username
      public_key = file("~/.ssh/id_rsa.pub")
    }

    plan {
        publisher = "128technology"
        product = "128technology_conductor_hourly"
        name = "128technology_conductor_private_452"
    }

    source_image_reference {
        publisher = "128technology"
        offer = "128technology_conductor_hourly"
        sku = "128technology_conductor_private_452"
        version = "latest"
    }

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "StandardSSD_LRS"
    }
}
