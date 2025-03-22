resource "azurecaf_name" "rg_name" {
  name          = "amines"
  resource_type = "azurerm_resource_group"
  prefixes      = ["dev"]
  suffixes      = ["y", "z"]
  random_length = 3
  clean_input   = true
}

resource "azurerm_resource_group" "rg" {
  location = "eastus2"
  name     = azurecaf_name.rg_name.result
  tags = {
    source = "terraform"
  }
}

resource "azurecaf_name" "sb_name" {
  name          = "amines"
  resource_type = "azurerm_servicebus_namespace"
  prefixes      = ["dev"]
  suffixes      = ["y", "z"]
  random_length = 3
  clean_input   = true
}

resource "azurerm_servicebus_namespace" "sb_namespace" {
  name                = azurecaf_name.sb_name.result
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  tags = {
    source = "terraform"
  }
}

resource "azurecaf_name" "queue_name" {
  name          = "testing"
  resource_type = "azurerm_servicebus_queue"
  prefixes      = ["dev"]
  suffixes      = ["y", "z"]
  random_length = 3
  clean_input   = true
}

resource "azurerm_servicebus_queue" "sb_queue" {
  name                = azurecaf_name.queue_name.result
  namespace_id      = azurerm_servicebus_namespace.sb_namespace.id
  max_delivery_count  = 5
  lock_duration       = "PT5M"
  requires_session    = false
  dead_lettering_on_message_expiration = true
  status             = "Active"
}
