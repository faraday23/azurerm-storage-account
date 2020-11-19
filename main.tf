locals {
  resource_group_name  = "${var.names.resource_group_type}-${var.names.product_name}-${var.names.environment}-${var.names.location}"
  storage_account_name = "sa-${var.names.resource_group_type}-${var.names.product_name}-${var.names.environment}-${var.names.location}"
}

resource "random_string" "random" {
  length  = 24
  special = false
  upper   = false
}

resource "azurerm_storage_account" "azsa" {
  name                     = random_string.random.result
  resource_group_name      = local.resource_group_name
  location                 = var.location
  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
  access_tier              = var.access_tier
  allow_blob_public_access = var.allow_blob_public_access

  identity {
    type = "SystemAssigned"
  }

  blob_properties {
    delete_retention_policy {
      days = var.retention_days
    }
  }

  tags = merge(var.tags, {"name": local.storage_account_name})
}

resource "azurerm_storage_account_network_rules" "netrule" {
  resource_group_name  = local.resource_group_name
  storage_account_name = azurerm_storage_account.azsa.name
  default_action       = "Deny"
  ip_rules             = values(var.authorized_subnets)
  bypass               = ["AzureServices"]
}

output "primary_access_key" {
    value = azurerm_storage_account.azsa.primary_access_key
}

output "secondary_access_key" {
    value = azurerm_storage_account.azsa.secondary_access_key
}

output "storage_account_name" {
  value = azurerm_storage_account.azsa.name
}

output "storage_account_id" {
  value = azurerm_storage_account.azsa.id
}

