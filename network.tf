resource "azurerm_virtual_network" "t128_vnet" {
    name = "Terraform_test"
    location = data.azurerm_resource_group.pre_defined.location
    resource_group_name = var.azure_resource_group_name
    address_space = ["192.168.0.0/16"]
}

resource "azurerm_subnet" "management" {
    name = "Management_network"
    resource_group_name = var.azure_resource_group_name
    virtual_network_name = azurerm_virtual_network.t128_vnet.name
    address_prefixes = ["192.168.0.0/24"]
}

resource "azurerm_subnet" "lan" {
    name = "lan_network"
    resource_group_name = var.azure_resource_group_name
    virtual_network_name = azurerm_virtual_network.t128_vnet.name
    address_prefixes = ["192.168.1.0/24"]
}

resource "azurerm_subnet" "wan" {
    name = "wan_network"
    resource_group_name = var.azure_resource_group_name
    virtual_network_name = azurerm_virtual_network.t128_vnet.name
    address_prefixes = ["192.168.2.0/24"]
}

resource "azurerm_public_ip" "router1_mgmt" {
    name                = "router1_mgmt"
    resource_group_name = var.azure_resource_group_name
    location            = data.azurerm_resource_group.pre_defined.location
    allocation_method   = "Static"
}

resource "azurerm_public_ip" "router1_wan" {
    name                = "router1_wan"
    resource_group_name = var.azure_resource_group_name
    location            = data.azurerm_resource_group.pre_defined.location
    allocation_method   = "Static"
}

resource "azurerm_network_interface" "router1_mgmt" {
  name                = "router1_management"
  location            = data.azurerm_resource_group.pre_defined.location
  resource_group_name = var.azure_resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.management.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.router1_mgmt.id
  }
}

resource "azurerm_network_interface" "router1_wan" {
  name                = "router1_wan"
  location            = data.azurerm_resource_group.pre_defined.location
  resource_group_name = var.azure_resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.wan.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.router1_wan.id
  }
}

resource "azurerm_network_interface" "router1_lan" {
  name                = "router1_lan"
  location            = data.azurerm_resource_group.pre_defined.location
  resource_group_name = var.azure_resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.lan.id
    private_ip_address_allocation = "Dynamic"
  }
}
