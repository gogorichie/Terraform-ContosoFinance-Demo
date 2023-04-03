provider "azurerm" {
  features {}
}

locals {
  tags = merge({ "NS_Application" = var.NS_Application }, { "NS_Environment" = var.NS_Environment })
}
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