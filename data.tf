variable "azure_resource_group_name" {}
variable "conductor1_ip" {}
variable "t128_instance_size" { default = "Standard_D8_v3"}
variable "t128_linux_admin_username" { default = "t128"}
variable "t128_admin_pw_hash" { default = "$6$JEmS0I7bNwkO96uX$8Wz.qrafYlE9fZnQu3WFbp4Nhc.Da4u010OSrUzaNzAR7OESfWE1cBEeDP5kVZZjnsv/Ez6VPCRoMV0O3GdET/" }
variable "node_name" { default = "node1" }
variable "router_name" { default = "router1" }

### Configure the Azure Provider
provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "pre_defined" {
    name = var.azure_resource_group_name
}
