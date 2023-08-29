# terraform-aws-template

[![Lint Status](https://github.com/tothenew/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-aws-template)](https://github.com/tothenew/terraform-aws-template/blob/master/LICENSE)

This module sets up different types of NOSQL Database in Azure Cosmosdb, including 
- Mongodb
- postgresql
- Cassandra
- SQL
- Gremlin
- table

## Providers

| Name | Version |
|------|---------|
| <a name="provider_Azure"></a> [azurerm](#provider\_azure) | >=3.0 |

## Prerequisites

Before you begin, ensure you have the following requirements met:

1. Install Terraform (>= 1.3.0). You can download the latest version of Terraform from the official website: [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)

2. Azure CLI installed and configured with appropriate access rights. You can install the Azure CLI from [https://docs.microsoft.com/en-us/cli/azure/install-azure-cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

## Resources

| Name                                     | Description                                                            | Type              |
|------------------------------------------|------------------------------------------------------------------------|-------------------|
| `azurerm_cosmosdb_account`               | Azure Cosmos DB Account - A globally distributed, multi-model database service by Microsoft Azure. | `azurerm`           |
| `azurerm_cosmosdb_mongo_database`        | Azure MongoDB Database - A MongoDB-compatible NoSQL database service on Azure Cosmos DB. | `azurerm`           |
| `azurerm_cosmosdb_mongo_collection`      | Azure MongoDB Collection - A collection within an Azure Cosmos DB MongoDB database. | `azurerm`           |
| `azurerm_cosmosdb_postgresql_cluster`    | Azure Cosmos DB PostgreSQL Cluster - A PostgreSQL-compatible database service on Azure Cosmos DB. | `azurerm`           |
| `azurerm_cosmosdb_postgresql_firewall_rule` | Azure Cosmos DB PostgreSQL Cluster Firewall Rule - A rule that controls network access to the PostgreSQL cluster in Azure Cosmos DB. | `azurerm`           |
| `azurerm_cosmosdb_cassandra_keyspace`    | Azure Cosmos DB Cassandra Keyspace - A keyspace within an Azure Cosmos DB Cassandra API. | `azurerm`           | 
| `azurerm_cosmosdb_cassandra_table`       | Azure Cosmos DB Cassandra Table - A table within an Azure Cosmos DB Cassandra keyspace. | `azurerm`           |
| `azurerm_cosmosdb_gremlin_database`      | Azure Cosmos DB Gremlin Database - A graph database service for building applications with graph data. | `azurerm`           | 
| `azurerm_cosmosdb_gremlin_graph`         | Azure Cosmos DB Gremlin Graph - A graph within an Azure Cosmos DB Gremlin database. | `azurerm`           |
| `azurerm_cosmosdb_sql_database`          | Azure Cosmos DB SQL Database - A SQL database service on Azure Cosmos DB. | `azurerm`           |
| `azurerm_cosmosdb_sql_container`         | Azure Cosmos DB SQL Container - A container within an Azure Cosmos DB SQL database. | `azurerm`           | 
| `azurerm_cosmosdb_table`                 | Azure Cosmos DB Table Database - A table database within an Azure Cosmos DB account. | `azurerm`           |



### data source Variables

| Variable Name             | Description                                | Type   | Default Value | Required |
|---------------------------|--------------------------------------------|--------|---------------|----------|
| `resource_group_name`     | The name of existing Azure Resource Group.      | string | N/A           | Yes      |
| `vnet_name`               | The name of existing Azure Virtual Network.     | string | N/A           | Yes      |
| `subnet_name`             | The name of existing Azure Subnet.              | string | N/A           | Yes      |
    
# Azure CosmosDB Account Resource

This Terraform resource deploys an Azure CosmosDB account with the specified configuration.

## Input Variables

| Variable Name                            | Description                                   | Type   | Default Value      |
|-----------------------------------------|-----------------------------------------------|--------|--------------------|
| `create_postgresql`                      | Create PostgreSQL account?                    | bool   | `false`            |
| `account_name`                           | Name of the CosmosDB account                 | string |                    |
| `location_id`                            | Location for the CosmosDB account            | string |                    |
| `public_network_access_enabled`          | Enable public network access?                | bool   |                    |
| `enable_automatic_failover`              | Enable automatic failover?                   | bool   |                    |
| `enable_free_tier`                       | Enable free tier?                            | bool   |                    |
| `enable_multiple_write_locations`        | Enable multiple write locations?             | bool   |                    |
| `consistency_policy.consistency_level`   | Consistency level                            | string |                    |
| `consistency_policy.max_interval_in_seconds` | Max interval in seconds for consistency | number |                    |
| `consistency_policy.max_staleness_prefix` | Max staleness prefix for consistency     | number |                    |
| `create_sql`                             | Create SQL API capability?                   | bool   | `false`            |
| `capabilities`                            | List of enabled capabilities                 | list   |                    |
| `create_mongodb`                         | Create MongoDB API capability?               | bool   | `false`            |
| `create_cassandra`                       | Create Cassandra API capability?             | bool   | `false`            |
| `create_table`                           | Create Table API capability?                 | bool   | `false`            |
| `create_gremlin`                         | Create Gremlin API capability?               | bool   | `false`            |
| `analytical_storage.enabled`             | Enable analytical storage?                   | bool   | `false`            |
| `analytical_storage.schema_type`         | Schema type for analytical storage           | string |                    |
| `geo_locations`                          | List of geo-locations and configurations     | list   |                    |
| `backup_enabled`                         | Enable backups?                              | bool   | `false`            |
| `backup_type`                            | Backup type                                  | string |                    |
| `backup_interval`                        | Backup interval in minutes (Periodic type)   | number |                    |
| `backup_retention`                       | Backup retention in hours (Periodic type)    | number |                    |
| `storage_redundancy`                     | Storage redundancy (Periodic type)           | string |                    |
| `allowed_cidrs`                          | List of allowed CIDR ranges                  | list   | `["0.0.0.0/0"]`    |
| `is_virtual_network_filter_enabled`      | Enable virtual network filter?               | bool   | `false`            |
| `network_acl_bypass_for_azure_services`  | Network ACL bypass for Azure services        | bool   | `false`            |
| `network_acl_bypass_ids`                 | List of Network ACL bypass IDs               | list   | `[]`               |
| `virtual_network_rule`                   | List of virtual network rules                | list   | `[]`               |
| `identity`                               | Identity configuration                        | string |                    |

## Example Usage

```hcl
module "cosmosdb" {
  source = "./modules/cosmosdb"

  create_postgresql                = false
  account_name                     = "mycosmosdb"
  location_id                     = "East US"
  public_network_access_enabled    = true
  enable_automatic_failover       = true
  enable_free_tier                = false
  enable_multiple_write_locations = false
  consistency_policy = {
    consistency_level         = "Eventual"
    max_interval_in_seconds   = 5
    max_staleness_prefix      = 100
  }
  create_sql                      = false
  capabilities = []
  create_mongodb                 = true
  create_cassandra               = false
  create_table                   = false
  create_gremlin                 = false
  analytical_storage = {
    enabled    = true
    schema_type = "AnalyticalStorageSchema"
  }
  geo_locations = [
    {
      geo_location          = "East US"
      failover_priority     = 0
      zone_redundant        = false
    }
  ]
  backup_enabled                 = true
  backup_type                    = "Periodic"
  backup_interval                = 60
  backup_retention               = 7
  storage_redundancy            = "LRS"
  allowed_cidrs                  = ["10.0.0.1", "10.0.0.2", "10.20.0.0/16"]
  is_virtual_network_filter_enabled = true
  network_acl_bypass_for_azure_services = false
  network_acl_bypass_ids         = []
  virtual_network_rule = [
    {
      id = "subnet-id"
      ignore_missing_vnet_service_endpoint = false
    }
  ]
  identity                        = "SystemAssigned"
}
```
# Azure CosmosDB MongoDB Database and Collection Resources

These Terraform resources deploy an Azure CosmosDB MongoDB database and collection with the specified configuration.

## Input Variables

### For MongoDB Database (`azurerm_cosmosdb_mongo_database`)

| Variable Name          | Description                           | Type    | Default Value  |
|------------------------|---------------------------------------|---------|----------------|
| `create_mongodb`       | Create MongoDB database?              | bool    | `false`        |
| `db_name`              | Name of the MongoDB database          | string  |                |
| `resource_group_name`  | Name of the resource group            | string  |                |
| `max_throughput`       | Max throughput for autoscaling        | number  |                |

### For MongoDB Collection (`azurerm_cosmosdb_mongo_collection`)

| Variable Name                      | Description                          | Type    | Default Value  |
|------------------------------------|--------------------------------------|---------|----------------|
| `create_mongodb`                   | Create MongoDB collection?            | bool    | `false`        |
| `collection_name`                  | Name of the MongoDB collection        | string  |                |
| `resource_group_name`              | Name of the resource group            | string  |                |
| `default_ttl_seconds`              | Default TTL in seconds                | number  |                |
| `shard_key`                        | Shard key for the collection         | string  |                |
| `collection_max_throughput`        | Max throughput for autoscaling        | number  |                |
| `indexes`                          | List of index configurations           | list    | []             |

### For Indexes (`indexes`)

| Variable Name                      | Description                          | Type    | Default Value  |
|------------------------------------|--------------------------------------|---------|----------------|
| `mongo_index_keys`                 | List of index keys                    | list    | []             |
| `mongo_index_unique`               | Create unique index?                  | bool    | `false`        |


## Example Usage

```hcl
resource "azurerm_cosmosdb_mongo_database" "mongodb" {
  count             = true
  create_mongodb    = true
  db_name           = "mydatabase"
  resource_group_name = "myresourcegroup"
  max_throughput    = 400
}

resource "azurerm_cosmosdb_mongo_collection" "collection" {
  count             = true
  create_mongodb    = true
  collection_name   = "mycollection"
  resource_group_name = "myresourcegroup"
  default_ttl_seconds = 3600
  shard_key         = "/myshardkey"
  collection_max_throughput = 400

  indexes = [
    {
      mongo_index_keys   = ["/key1", "/key2"]
      mongo_index_unique = false
    },
    {
      mongo_index_keys   = ["/key3"]
      mongo_index_unique = true
    }
  ]
}
```

Replace the values in the `Example Usage` section with your specific configuration.

This is an overview of the input variables and default values for the Terraform resources thatthat deploy Azure CosmosDB MongoDB database and collection. Customize the configuration as needed for your Terraform project.

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_collection


# Azure CosmosDB PostgreSQL Cluster and Firewall Rule Resources

These Terraform resources deploy an Azure CosmosDB PostgreSQL Cluster and Firewall Rule with the specified configuration.

## Input Variables

### For PostgreSQL Cluster (`azurerm_cosmosdb_postgresql_cluster`)

| Variable Name                           | Description                            | Type    | Default Value  |
|-----------------------------------------|----------------------------------------|---------|----------------|
| `create_postgresql`                     | Create PostgreSQL Cluster?             | bool    | `false`        |
| `psql_cluster_name`                     | Name of the PostgreSQL Cluster         | string  |                |
| `resource_group_name`                   | Name of the resource group             | string  |                |
| `location_id`                           | Location ID                            | string  |                |
| `admin_login_password`                  | Administrator login password           | string  |                |
| `coordinator_storage_quota_in_mb`       | Coordinator storage quota (in MB)     | number  |                |
| `coordinator_public_ip_access_enabled`  | Is public IP access enabled for coordinator? | bool  | `false`        |
| `vcore_count`                           | Coordinator vCore count                | number  |                |
| `node_count`                            | Node count                             | number  |                |
| `psql_version`                          | PostgreSQL version                     | string  |                |
| `citus_version`                         | Citus extension version                | string  |                |
| `ha_enabled`                            | Is high availability enabled?          | bool    | `false`        |
| `node_server_edition`                   | Node server edition                    | string  |                |
| `enable_maintenance`                    | Enable maintenance window?             | bool    | `false`        |
| `maintenance_window`                    | Maintenance window configuration       | object  |                |

### For Maintenance Window (`maintenance_window`)

| Variable Name     | Description                  | Type    | Default Value  |
|-------------------|------------------------------|---------|----------------|
| `day_of_week`     | Day of the week for maintenance window (0 = Sunday, 1 = Monday) | number  | `0` |
| `start_hour`      | Start hour of the maintenance window | number  | `0` |
| `start_minute`    | Start minute of the maintenance window | number  | `0` |

### For PostgreSQL Firewall Rule (`azurerm_cosmosdb_postgresql_firewall_rule`)

| Variable Name       | Description                            | Type    | Default Value  |
|---------------------|----------------------------------------|---------|----------------|
| `create_postgresql` | Create PostgreSQL Firewall Rule?        | bool    | `false`        |
| `private_endpoint`  | Use private endpoint for PostgreSQL?   | bool    | `false`        |
| `firewallrule_name` | Name of the PostgreSQL Firewall Rule   | string  |                |
| `start_ip`          | Start IP address for the rule          | string  |                |
| `end_ip`            | End IP address for the rule            | string  |                |

## Example Usage

```hcl
resource "azurerm_cosmosdb_postgresql_cluster" "my-cluster" {
  count                                = true
  create_postgresql                    = true
  psql_cluster_name                    = "mypostgresqlcluster"
  resource_group_name                  = "myresourcegroup"
  location_id                          = "eastus"
  administrator_login_password         = "mypassword"
  coordinator_storage_quota_in_mb      = 1024
  coordinator_public_ip_access_enabled = false
  vcore_count                          = 4
  node_count                           = 3
  psql_version                         = "11.2"
  citus_version                        = "9.5"
  ha_enabled                           = true
  node_server_edition                  = "MemoryOptimized"
  enable_maintenance                   = true
  maintenance_window                   = {
    day_of_week   = 1
    start_hour    = 2
    start_minute  = 30
  }
}

resource "azurerm_cosmosdb_postgresql_firewall_rule" "example" {
  count                           = true
  create_postgresql               = true
  private_endpoint                = false
  firewallrule_name               = "myfirewallrule"
  start_ip                        = "10.0.0.1"
  end_ip                          = "10.0.0.255"
}
```

Replace the values in the `Example Usage` section with your specific configuration.

This is an overview of the input variables and default values for the Terraform resources that deploy Azure CosmosDB PostgreSQL Cluster and Firewall Rule. for more customization please refer to terraform documentation

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_postgresql_cluster


# Azure CosmosDB Cassandra Keyspace and Cassandra Table Resources

These Terraform resources deploy an Azure CosmosDB Cassandra Keyspace and Cassandra Table with the specified configuration.

## Input Variables

### For Cassandra Keyspace (`azurerm_cosmosdb_cassandra_keyspace`)

| Variable Name             | Description                             | Type    | Default Value  |
|---------------------------|-----------------------------------------|---------|----------------|
| `create_cassandra`        | Create Cassandra Keyspace?              | bool    | `false`        |
| `keyspace_name`           | Name of the Cassandra Keyspace          | string  |                |
| `resource_group_name`     | Name of the resource group              | string  |                |
| `keyspace_max_throughput` | Max throughput for the Keyspace         | number  |                |

### For Cassandra Table (`azurerm_cosmosdb_cassandra_table`)

| Variable Name         | Description                             | Type    | Default Value  |
|-----------------------|-----------------------------------------|---------|----------------|
| `create_cassandra`    | Create Cassandra Table?                 | bool    | `false`        |
| `keyspace_table`      | Name of the Cassandra Table             | string  |                |
| `columns`             | List of column definitions               | list(object) | [] |
| `partition_key_name`  | Name of the partition key column        | string  |                |

### For Column Definitions (`columns`)

| Variable Name | Description                              | Type   | Default Value  |
|---------------|------------------------------------------|--------|----------------|
| `name`        | Name of the column                       | string |                |
| `type`        | Type of the column (e.g., "int", "text") | string |                |

## Example Usage

```hcl
resource "azurerm_cosmosdb_cassandra_keyspace" "keyspace" {
  count               = true
  create_cassandra    = true
  keyspace_name       = "mycassandrakeyspace"
  resource_group_name = "myresourcegroup"
  keyspace_max_throughput = 400
}

resource "azurerm_cosmosdb_cassandra_table" "cassandra_table" {
  count               = true
  create_cassandra    = true
  keyspace_table      = "mycassandratable"
  partition_key_name  = "id"

  columns = [
    {
      name = "id",
      type = "text"
    },
    {
      name = "value",
      type = "int"
    }
  ]
}
```

Replace the values in the `Example Usage` section with your specific configuration.

This is an overview of the input variables and default values for the Terraform resources that deploy Azure CosmosDB Cassandra Keyspace and Cassandra Table. for more customization please refer to terraform documentation


## Azure CosmosDB Gremlin Database and Gremlin Graph Resources

The Terraform resources below deploy an Azure CosmosDB Gremlin Database and Gremlin Graph with the specified configuration.

### Input Variables

| Variable                             | Description                                | Type    | Default Value |
|--------------------------------------|--------------------------------------------|---------|---------------|
| `create_gremlin`                     | Create Gremlin Database and Graph?         | bool    | `false`       |
| `gremlin_db_name`                    | Name of the Gremlin Database               | string  |               |
| `resource_group_name`                | Name of the resource group                 | string  |               |
| `gremlin_max_throughput`             | Max throughput for the Gremlin Database    | number  |               |
| `gremlin_graph_config.graph_name`    | Name of the Gremlin Graph                  | string  |               |
| `gremlin_graph_config.partition_key_path` | Path for the partition key in the Graph | string  |               |
| `gremlin_graph_config.graph_throughput`  | Throughput for the Gremlin Graph       | number  |               |
| `gremlin_graph_config.index_policy.automatic` | Enable automatic indexing?        | bool    | `false`       |
| `gremlin_graph_config.index_policy.indexing_mode` | Indexing mode (e.g., "consistent", "lazy") | string |             |
| `gremlin_graph_config.index_policy.included_paths` | List of included paths for indexing | list(string) | []       |
| `gremlin_graph_config.index_policy.excluded_paths` | List of excluded paths from indexing | list(string) | []       |
| `gremlin_graph_config.conflict_resolution_policy.mode` | Conflict resolution mode (e.g., "LastWriterWins") | string |         |
| `gremlin_graph_config.conflict_resolution_policy.conflict_resolution_path` | Path for conflict resolution | string |     |
| `gremlin_graph_config.unique_key.paths` | List of paths for unique keys               | list(string)  | []         |


### Example Usage

```hcl
resource "azurerm_cosmosdb_gremlin_database" "db" {
  count               = true
  create_gremlin      = true
  gremlin_db_name     = "mygremlindb"
  resource_group_name = "myresourcegroup"
  gremlin_max_throughput = 400
}

resource "azurerm_cosmosdb_gremlin_graph" "example" {
  name                = "tfex-cosmos-gremlin-graph"
  resource_group_name = data.azurerm_cosmosdb_account.example.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.example.name
  database_name       = azurerm_cosmosdb_gremlin_database.example.name
  partition_key_path  = "/Example"
  throughput          = 400

  index_policy {
    automatic      = true
    indexing_mode  = "consistent"
    included_paths = ["/*"]
    excluded_paths = ["/\"_etag\"/?"]
  }

  conflict_resolution_policy {
    mode                     = "LastWriterWins"
    conflict_resolution_path = "/_ts"
  }

  unique_key {
    paths = ["/definition/id1", "/definition/id2"]
  }
}
```

This is an overview of the input variables and default values for the Terraform resources that deploy Azure CosmosDB Gremlin Database and Gremlin Graph. for more customization please refer to terraform documentation
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_gremlin_graph

## Azure CosmosDB SQL Database and SQL Container Resources

The Terraform resources below deploy an Azure CosmosDB SQL Database and SQL Container with the specified configuration.

### Input Variables

| Variable                             | Description                                | Type    | Default Value |
|--------------------------------------|--------------------------------------------|---------|---------------|
| `create_sql`                         | Create SQL Database and Container?         | bool    | `false`       |
| `sql_db_name`                        | Name of the SQL Database                   | string  |               |
| `resource_group_name`                | Name of the resource group                 | string  |               |
| `sql_max_throughput`                 | Max throughput for the SQL Database        | number  |               |
| `cosmosdb_container_config.container_name` | Name of the SQL Container            | string  |               |
| `cosmosdb_container_config.partition_key_path` | Path for the partition key in the Container | string |             |
| `cosmosdb_container_config.partition_key_version` | Partition key version (e.g., "2.0") | string |             |
| `cosmosdb_container_config.container_throughput` | Throughput for the SQL Container     | number  |               |
| `cosmosdb_container_config.default_ttl` | Default Time-to-Live (TTL) for documents | number  |             |
| `cosmosdb_container_config.indexing_policy.indexing_mode` | Indexing mode (e.g., "consistent", "lazy") | string |         |
| `cosmosdb_container_config.indexing_policy.included_paths` | List of included paths for indexing | list(string) | []       |
| `cosmosdb_container_config.indexing_policy.excluded_paths` | List of excluded paths from indexing | list(string) | []       |
| `cosmosdb_container_config.unique_key.paths` | List of paths for unique keys           | list(string) | []         |

### Output Variables

- None (These resources don't have specific output variables)

### Example Usage

```hcl
resource "azurerm_cosmosdb_sql_database" "db" {
  count               = true
  create_sql          = true
  sql_db_name         = "mysqldb"
  resource_group_name = "myresourcegroup"
  sql_max_throughput  = 400
}

resource "azurerm_cosmosdb_sql_container" "example" {
  name                  = "example-container"
  resource_group_name   = data.azurerm_cosmosdb_account.example.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.example.name
  database_name         = azurerm_cosmosdb_sql_database.example.name
  partition_key_path    = "/definition/id"
  partition_key_version = 1
  throughput            = 400

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}
```

This is an overview of the input variables and default values for the Terraform resources that deploy Azure CosmosDB SQL Database and SQL Container.  for more customization please refer to terraform documentation.
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container

## Azure CosmosDB Table Resource

The Terraform resource below deploys an Azure CosmosDB Table with the specified configuration.

### Input Variables

| Variable                             | Description                                | Type    | Default Value |
|--------------------------------------|--------------------------------------------|---------|---------------|
| `create_table`                       | Create CosmosDB Table?                     | bool    | `false`       |
| `table_name`                         | Name of the CosmosDB Table                 | string  |               |
| `resource_group_name`                | Name of the resource group                 | string  |               |
| `max_throughput`                     | Max throughput for autoscaling             | number  |               |

### Example Usage

```hcl
resource "azurerm_cosmosdb_table" "table" {
  count               = true
  create_table        = true
  table_name          = "mytable"
  resource_group_name = "myresourcegroup"
  max_throughput      = 400
}
```

This is an overview of the input variables and default values for the Terraform resources that deploys an Azure CosmosDB Table.for more customization please refer to terraform documentation.
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_table


## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-aws-template/blob/main/LICENSE) for full details.