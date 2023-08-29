resource "azurerm_cosmosdb_postgresql_cluster" "my-cluster" {
  count                                = var.create_postgresql ? 1 : 0
  name                                 = var.psql_cluster_name
  resource_group_name                  = var.resource_group_name
  location                             = var.location_id
  administrator_login_password         = var.admin_login_password
  coordinator_storage_quota_in_mb      = var.coordinator_storage_quota_in_mb
  coordinator_public_ip_access_enabled = var.coordinator_public_ip_access_enabled
  coordinator_vcore_count              = var.vcore_count
  node_count                           = var.node_count
  sql_version                          = var.psql_version
  citus_version                        = var.citus_version
  ha_enabled                           = var.ha_enabled
  node_server_edition                  = var.node_server_edition

dynamic "maintenance_window" {
    for_each = var.enable_maintenance ? [var.maintenance_window] : []
    content {
      day_of_week   = var.maintenance_window.day_of_week
      start_hour    = var.maintenance_window.start_hour
      start_minute  = var.maintenance_window.start_minute
    }
  }

}


resource "azurerm_cosmosdb_postgresql_firewall_rule" "example" {
  count                           = var.create_postgresql == true && var.private_endpoint == false ? 1 : 0 
  name                            = var.firewallrule_name
  cluster_id                      = azurerm_cosmosdb_postgresql_cluster.my-cluster[0].id
  start_ip_address                = var.start_ip
  end_ip_address                  = var.end_ip
}
