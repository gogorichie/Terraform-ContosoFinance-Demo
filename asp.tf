
#App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "${var.appname}-${var.NS_Environment}-Plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = var.NS_Environment == "prod" ? "P1v3" : "B1"
  tags                = local.tags
}

resource "azurerm_linux_web_app" "web-app-site" {
  name                       = "${var.appname}-${var.NS_Environment}-Site"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  service_plan_id            = azurerm_service_plan.asp.id
  client_affinity_enabled    = false
  client_certificate_enabled = false
  client_certificate_mode    = "Required"
  enabled                    = true
  https_only                 = true
  tags                       = local.tags
  site_config {
    always_on               = false
    minimum_tls_version     = "1.2"
    scm_minimum_tls_version = "1.2"
  }
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY             = azurerm_application_insights.ai.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING      = azurerm_application_insights.ai.connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION = "~3"
  }
  depends_on = [
    azurerm_service_plan.asp
  ]
}

resource "azurerm_app_service_source_control" "apssc-site" {
  app_id                 = azurerm_linux_web_app.web-app-site.id
  repo_url               = "https://github.com/SoniaConti/ContosoFinance-Demo-Web.git"
  branch                 = "master"
  use_manual_integration = true
  use_mercurial          = false
  depends_on = [
    azurerm_linux_web_app.web-app-site
  ]
}

resource "azurerm_linux_web_app" "web-app-api" {
  name                       = "${var.appname}-${var.NS_Environment}-Api"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  service_plan_id            = azurerm_service_plan.asp.id
  client_affinity_enabled    = false
  client_certificate_enabled = false
  client_certificate_mode    = "Required"
  enabled                    = true
  https_only                 = true
  tags                       = local.tags
  site_config {
    always_on               = false
    minimum_tls_version     = "1.2"
    scm_minimum_tls_version = "1.2"
  }
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY             = azurerm_application_insights.ai.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING      = azurerm_application_insights.ai.connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION = "~3"
  }
  depends_on = [
    azurerm_service_plan.asp
  ]
}

resource "azurerm_app_service_source_control" "apssc-api" {
  app_id                 = azurerm_linux_web_app.web-app-api.id
  repo_url               = "https://github.com/SoniaConti/ContosoFinance-Demo-API.git"
  branch                 = "master"
  use_manual_integration = true
  use_mercurial          = false
  depends_on = [
    azurerm_linux_web_app.web-app-api
  ]
}
