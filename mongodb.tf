resource "azurerm_cosmosdb_mongo_database" "mongodb" {
  count                         = var.create_mongodb ? 1 : 0
  name                          = var.db_name
  resource_group_name           = data.azurerm_resource_group.rg.name
  account_name                  = azurerm_cosmosdb_account.cosmosdb_acc.0.name
  # throughput                    = var.mongo_db.throughput

 autoscale_settings {

          max_throughput = var.mongo_db.max_throughput

  }
}


resource "azurerm_cosmosdb_mongo_collection" "collection" {
  count                  = var.create_mongodb  ? 1 : 0
  name                   = var.mongo_db_collections.collection_name
  resource_group_name    = data.azurerm_resource_group.rg.name
  account_name           = azurerm_cosmosdb_account.cosmosdb_acc.0.name
  database_name          = azurerm_cosmosdb_mongo_database.mongodb.0.name
  default_ttl_seconds    = var.mongo_db_collections.default_ttl_seconds 
  shard_key              = var.mongo_db_collections.shard_key
  # throughput             = each.value.collection_max_throughput
  # analytical_storage_ttl = var.mongo_db_collections.analytical_storage_ttl 

  # Autoscaling is optional and depends on max throughput parameter. Mutually exclusive vs. throughput. 
  # dynamic "
  autoscale_settings {
    # for_each = var.mongo_db_collections.collection_max_throughput 
    # content {
      max_throughput = var.mongo_db_collections.collection_max_throughput
    # }
  }

  # Index is optional
  dynamic "index" {
  for_each = var.indexes
    content {
      keys   = var.indexes.mongo_index_keys
      unique = var.indexes.mongo_index_unique != null ? var.indexes.mongo_index_unique : null
    }
  }

  depends_on = [
    azurerm_cosmosdb_mongo_database.mongodb 
  ]
}





