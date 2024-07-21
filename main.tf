resource "random_pet" "rg_har" {
  prefix = var.resource_group_har_prefix
}

resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg_har.id
  location = var.resource_group_us
}

resource "random_string" "har" {
  length  = 25
  lower   = true
  upper   = false
  special = false
}

resource "azurerm_container_group" "container" {
  name                = "${var.container_group_har_prefix}-${random_string.container_har.result}"
  location            = azurerm_resource_group.rg.us
  resource_group_name = azurerm_resource_group.rg.har
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = var.restart_policy

  container {
    name   = "${var.container_har_prefix}-${random_string.container_har.result}"
    image  = var.image
    cpu    = var.cpu_cores
    memory = var.memory_in_gb

    ports {
      port     = var.port
      protocol = "TCP"
    }
  }
}
