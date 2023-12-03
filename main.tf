provider "azurerm" {
  features = {}
}

variable "location" {
  type    = string
  default = "WestEurope"

  validation {
    condition     = var.location == "WestEurope" || var.location == "NorthEurope"
    error_message = "Invalid location. Allowed values are WestEurope or NorthEurope."
  }
}

variable "ProjectName" {
  type    = string
  default = "ContosoFinance-Demo"
}

variable "hostingPlanName" {
  type    = string
  default = "ContosoFinance-Demo-Plan"
}

variable "webappname" {
  type    = string
  default = "ContosoFinance-Demo-Site"
}

variable "apiname" {
  type    = string
  default = "ContosoFinance-Demo-Api"
}

variable "sqlserverName" {
  type    = string
  default = "ContosoFinance-Demo-Sql"
}

variable "databaseName" {
  type    = string
  default = "contosofinancedemodb"
}

variable "skuName" {
  type    = string
  default = "F1"

  validation {
    condition     = var.skuName in ["F1", "D1", "B1", "B2", "B3", "S1", "S2", "S3", "P1", "P2", "P3", "P4"]
    error_message = "Invalid SKU name."
  }
}

variable "skuCapacity" {
  type    = number
  default = 1

  validation {
    condition     = var.skuCapacity >= 1 && var.skuCapacity <= 3
    error_message = "Invalid SKU capacity. It must be between 1 and 3."
  }
}

variable "sqlAdministratorLogin" {
  type    = string
  default = "SysAdmin"
}

variable "sqlAdministratorLoginPassword" {
  type    = string
  default = "Ajsy37_8fhewkb9!29Cfbchda"
}

variable "repoURL" {
  type    = string
  default = "https://github.com/SoniaConti/ContosoFinance-Demo-Web.git"
}

variable "branch" {
  type    = string
  default = "master"
}

variable "APIrepoURL" {
  type    = string
  default = "https://github.com/SoniaConti/ContosoFinance-Demo-API.git"
}

resource "azurerm_sql_server" "example" {
  name                         = var.sqlserverName
  location                     = var.location
  resource_group_name          = azurerm_resource_group.example.name
  administrator_login          = var.sqlAdministratorLogin
  administrator_login_password = var.sqlAdministratorLoginPassword
  version                      = "12.0"
}

resource "azurerm_sql_database" "example" {
  name                        = var.databaseName
  server_name                 = azurerm_sql_server.example.name
  resource_group_name         = azurerm_resource_group.example.name
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  max_size_bytes              = 1073741824
  sku_name                    = "Basic"
}

resource "azurerm_sql_firewall_rule" "example" {
  name                        = "AllowAllWindowsAzureIps"
  server_name                 = azurerm_sql_server.example.name
  resource_group_name         = azurerm_resource_group.example.name
  start_ip_address            = "0.0.0.0"
  end_ip_address              = "0.0.0.0"
}

resource "azurerm_app_service_plan" "example" {
  name                = var.hostingPlanName
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = var.skuName
    size = var.skuCapacity
  }
}

resource "azurerm_web_app" "example" {
  name                = var.webappname
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name

  server_farm_id = azurerm_app_service_plan.example.id

  site_config {
    always_on = true
  }

  source_control {
    repo_url                = var.repoURL
    branch                  = var.branch
    is_manual_integration  = true
  }

  app_settings = {
    "offersAPIUrl" = "https://${var.apiname}.azurewebsites.net/api/get"
  }
}

resource "azurerm_web_app" "api_example" {
  name                = var.apiname
  kind                = "api"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name

  server_farm_id = azurerm_app_service_plan.example.id

  source_control {
    repo_url                = var.APIrepoURL
    branch                  = var.branch
    is_manual_integration  = true
  }
}