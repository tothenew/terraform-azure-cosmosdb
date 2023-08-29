/*A keyspace is similar to an RDBMS database in that it includes indexes, user-defined types, indexes, replication factors,
 strategy, column families, data center awareness, etc.*/
resource "azurerm_cosmosdb_cassandra_keyspace" "keyspace" {
  count               = var.create_cassandra ? 1:0
  name                = var.keyspace_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_acc.0.name
  # throughput          = var.use_provisioned_throughput ? var.keyspace_throughput : null

  autoscale_settings {
      max_throughput = var.keyspace_max_throughput
  }
}

resource "azurerm_cosmosdb_cassandra_table" "cassandra_table" {
  count               = var.create_cassandra ? 1:0
  name                  = var.keyspace_table
  cassandra_keyspace_id = azurerm_cosmosdb_cassandra_keyspace.keyspace.0.id

  schema {
    dynamic "column" {
      for_each = var.columns

      content {
        name = column.value.name
        type = column.value.type
      }
    }

    partition_key {
      name = var.partition_key_name
    }
  } 
}

