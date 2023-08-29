resource "azurerm_cosmosdb_sql_database" "db" {
  count               = var.create_sql ? 1 : 0
  name                = var.sql_db_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_acc.0.name
#   throughput          = var.throughput

  autoscale_settings {
    max_throughput = var.sql_max_throughput
  }
}


resource "azurerm_cosmosdb_sql_container" "example" {
  count                 = var.create_sql ? 1 : 0
  name                  = var.cosmosdb_container_config.container_name
  resource_group_name   = data.azurerm_resource_group.rg.name
  account_name          = azurerm_cosmosdb_account.cosmosdb_acc.0.name
  database_name         = azurerm_cosmosdb_sql_database.db.0.name
  partition_key_path    = var.cosmosdb_container_config.partition_key_path
  partition_key_version = var.cosmosdb_container_config.partition_key_version
  throughput            = var.cosmosdb_container_config.container_throughput

  default_ttl = var.cosmosdb_container_config.default_ttl

  dynamic "indexing_policy" {
    for_each = [var.cosmosdb_container_config.indexing_policy]

    content {
      indexing_mode = indexing_policy.value.indexing_mode

      dynamic "included_path" {
        for_each = indexing_policy.value.included_paths

        content {
          path = included_path.value
        }
      }

      dynamic "excluded_path" {
        for_each = indexing_policy.value.excluded_paths

        content {
          path = excluded_path.value
        }
      }
    }
  }

  dynamic "unique_key" {
    for_each = [var.cosmosdb_container_config.unique_key]

    content {
      paths = unique_key.value.paths
    }
  }
}



