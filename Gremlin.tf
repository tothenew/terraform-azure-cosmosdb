resource "azurerm_cosmosdb_gremlin_database" "db" {
  count               = var.create_gremlin ? 1 : 0
  name                = var.gremlin_db_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_acc.0.name
#   throughput          = var.throughput

  autoscale_settings {
    max_throughput =   var.gremlin_max_throughput
  }
}


resource "azurerm_cosmosdb_gremlin_graph" "example" {
  count               = var.create_gremlin ? 1 : 0
  name                = var.gremlin_graph_config.graph_name
  resource_group_name = data.azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb_acc[0].name
  database_name       = azurerm_cosmosdb_gremlin_database.db.0.name
  partition_key_path  = var.gremlin_graph_config.partition_key_path
  throughput          = var.gremlin_graph_config.graph_throughput

  index_policy {
    automatic      = var.gremlin_graph_config.index_policy.automatic
    indexing_mode  = var.gremlin_graph_config.index_policy.indexing_mode
    included_paths = var.gremlin_graph_config.index_policy.included_paths
    excluded_paths = var.gremlin_graph_config.index_policy.excluded_paths
  }

  conflict_resolution_policy {
    mode                     = var.gremlin_graph_config.conflict_resolution_policy.mode
    conflict_resolution_path = var.gremlin_graph_config.conflict_resolution_policy.conflict_resolution_path
  }

  unique_key {
    paths = var.gremlin_graph_config.unique_key.paths
  }
}





