resource "azurerm_resource_group" "main" {   //
//Resource Group: to organize resources on Azure.
  name     = "sc-resource-group"
  location = "westeurope"

  tags = {
    environment = "Staging"
  }
}
//A virtual network and virtual subnet from which Kubernetes nodes can pick up IP addresses
resource "azurerm_virtual_network" "vnet" {
  name                = "sc-vnet"
  location            = "westeurope"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = "sc-resource-group"
}

resource "azurerm_subnet" "subnet" {
  name                      = "sc-subnet"
  virtual_network_name      = "sc-vnet"
  resource_group_name       = "sc-resource-group"
  address_prefix            = "10.1.0.0/24"
}