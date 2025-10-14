# Output important resource information
output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "web_app_site_url" {
  description = "URL of the main web application"
  value       = "https://${azurerm_linux_web_app.web-app-site.default_hostname}"
}

output "web_app_api_url" {
  description = "URL of the API application"
  value       = "https://${azurerm_linux_web_app.web-app-api.default_hostname}"
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL server"
  value       = azurerm_mssql_server.sql.fully_qualified_domain_name
  sensitive   = true
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.kv1.vault_uri
}

output "application_insights_connection_string" {
  description = "Application Insights connection string"
  value       = azurerm_application_insights.ai.connection_string
  sensitive   = true
}