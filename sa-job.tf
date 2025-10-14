
resource "azurerm_stream_analytics_job" "job" {
  name                                     = "${var.NS_Application}-${var.NS_Environment}-job"
  location                                 = azurerm_resource_group.rg.location
  resource_group_name                      = azurerm_resource_group.rg.name
  compatibility_level                      = "1.2"
  data_locale                              = "en-GB"
  events_late_arrival_max_delay_in_seconds = 60
  events_out_of_order_max_delay_in_seconds = 50
  events_out_of_order_policy               = "Adjust"
  output_error_policy                      = "Drop"
  streaming_units                          = 3
  tags                                     = local.tags


  transformation_query = <<QUERY
    SELECT *
    INTO [output]
    FROM [input]
QUERY

}

resource "azurerm_stream_analytics_reference_input_blob" "input_blob" {
  name                      = "input"
  stream_analytics_job_name = resource.azurerm_stream_analytics_job.job.name
  resource_group_name       = azurerm_resource_group.rg.name
  storage_account_name      = azurerm_storage_account.sa.name
  storage_account_key       = azurerm_storage_account.sa.primary_access_key
  storage_container_name    = azurerm_storage_container.container.name
  path_pattern              = "y={datetime:yyyy}/m={datetime:MM}/d={datetime:dd}/h={datetime:HH}/m={datetime:mm}"
  date_format               = "yyyy/MM/dd"
  time_format               = "HH"

  serialization {
    type     = "Json"
    encoding = "UTF8"
  }
}

resource "azurerm_stream_analytics_output_mssql" "output_msql" {
  name                      = "output"
  stream_analytics_job_name = resource.azurerm_stream_analytics_job.job.name
  resource_group_name       = azurerm_resource_group.rg.name
  server                    = azurerm_mssql_server.sql.fully_qualified_domain_name
  user                      = azurerm_mssql_server.sql.administrator_login
  password                  = azurerm_mssql_server.sql.administrator_login_password
  database                  = azurerm_mssql_database.db.name
  table                     = "ExampleTable"
  depends_on = [
    azurerm_mssql_server.sql
  ]
}
