#Create KeyVault SQL password
resource "random_password" "sqlpassword" {
  length  = 20
  special = true
}
#Create Key Vault Secret
resource "azurerm_key_vault_secret" "sqlkvsecret" {
  name         = "sql-server-password"
  value        = random_password.sqlpassword.result
  key_vault_id = azurerm_key_vault.kv1.id
  depends_on   = [azurerm_key_vault.kv1]
}

resource "azurerm_mssql_server" "sql" {
  name                         = "${var.NS_Application}-${var.NS_Environment}-sql"
  location                     = azurerm_resource_group.rg.location
  resource_group_name          = azurerm_resource_group.rg.name
  version                      = "12.0"
  administrator_login          = "SysAdmin"
  administrator_login_password = azurerm_key_vault_secret.sqlkvsecret.value
}

resource "azurerm_mssql_firewall_rule" "sql-fw-rule-azure-services" {
  name             = "${var.NS_Application}-${var.NS_Environment}-sql-fwrule-azure"
  server_id        = azurerm_mssql_server.sql.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
  depends_on = [
    azurerm_mssql_server.sql
  ]
}

# Add Virtual Network Rule for better security (requires VNet integration)
# This is commented out but shows best practice approach
# resource "azurerm_mssql_virtual_network_rule" "sql-vnet-rule" {
#   name      = "${var.NS_Application}-${var.NS_Environment}-sql-vnet-rule"
#   server_id = azurerm_mssql_server.sql.id
#   subnet_id = azurerm_subnet.app_subnet.id
# }

resource "azurerm_mssql_database" "db" {
  name                        = "${var.NS_Application}${var.NS_Environment}db"
  server_id                   = azurerm_mssql_server.sql.id
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  min_capacity                = 0.5
  max_size_gb                 = 10
  read_scale                  = false
  sku_name                    = "GP_S_Gen5_2"
  zone_redundant              = false
  auto_pause_delay_in_minutes = 60
  tags                        = local.tags
  storage_account_type        = "Local"
  depends_on = [
    azurerm_mssql_server.sql
  ]
}

