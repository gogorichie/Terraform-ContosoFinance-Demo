provider "azurerm" {
  features {}
}

locals {
  tags = merge({ "NS_Application" = var.NS_Application }, { "NS_Environment" = var.NS_Environment })
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "${var.appname}-${var.NS_Environment}-rg"
  location = var.location
  tags     = local.tags
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.appname}-${var.NS_Environment}-law"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.tags
  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_application_insights" "ai" {
  name                = "${var.appname}-${var.NS_Environment}-ai"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  workspace_id        = azurerm_log_analytics_workspace.law.id
  application_type    = "web"
  tags                = local.tags
  depends_on = [
    azurerm_log_analytics_workspace.law
  ]
}

resource "azurerm_storage_account" "sa" {
  name                     = "${var.appname}${var.NS_Environment}sa"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags                     = local.tags
}

resource "azurerm_storage_container" "container" {
  name                  = "${var.appname}-${var.NS_Environment}-blob"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "random_string" "kvname" {
  length  = 4
  upper   = false
  number  = true
  lower   = true
  special = false
}

resource "azurerm_key_vault" "kv1" {
  depends_on                  = [azurerm_resource_group.rg]
  name                        = "${var.appname}${var.NS_Environment}kv${random_string.kvname.result}"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "Get",
    ]
    secret_permissions = [
      "Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set",
    ]
    storage_permissions = [
      "Get",
    ]
  }
}