//Route table to allow external communication to internet from cluster
resource "azurerm_route_table" "main" {
  name                = "sc-routetable"
  location            = "westeurope"
  resource_group_name = "sc-resource-group"

  route {
    name                   = "default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "Internet"
  }
}

resource "azurerm_subnet_route_table_association" "main" {
  subnet_id      = "${azurerm_subnet.main.id}"
  route_table_id = "${azurerm_route_table.main.id}"
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "sc-aks"
  location            = "westeurope"
  resource_group_name = "sc-resource-group"

  linux_profile {
    admin_username = "admin"

    ssh_key {
      # remove any new lines using the replace interpolation function
      key_data = "${replace(var.admin_public_ssh_key, "\n", "")}"
    }
  }
//Three Kubernetes nodes in the provisioned subnet
  agent_pool_profile {
    name            = "nodepool"
    count           = "1"
    vm_size         = "Standard_F4
    os_type         = "Linux"
    os_disk_size_gb = 50

    # Required for advanced networking
    vnet_subnet_id = "${azurerm_subnet.main.id}"
  }

  service_principal {
    client_id     = "${var.service_principal_client_id}"
    client_secret = "${var.service_principal_client_secret}"
  }

  network_profile {
    network_plugin = "azure"
  }
}