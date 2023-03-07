resource "azurerm_container_registry" "main" {
  name                = "sc-registry"
  resource_group_name = "sc-resource-group"
  location            = "westeurope"
  sku                 = "Standard"
  admin_enabled       = true
}