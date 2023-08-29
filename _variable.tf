
variable "resource_group_name" {
  description = "The name of the Azure Resource Group where the resources will be created."
  type        = string
  default     = "rg"
}
variable "location_id" {
  default = "EAST US 2"
}

variable "create_mongodb" {
  type        = bool
  description = "If you want to create mongodb api for cosmosdb enable this check"
  default     = true
}

variable "create_postgresql" {
  type        = bool
  description = "If you want to create PostgreSQL api for cosmosdb enable this check"
  default     = false
}

variable "create_cassandra" {
  type        = bool
  description = "If you want to create apache cassandra api for cosmosdb enable this check"
  default     = false
}

variable "create_table" {
  type        = bool
  description = "If you want to create Table api for cosmosdb enable this check"
  default     = false
}

variable "create_sql" {
  type        = bool
  description = "If you want to create SQL api for cosmosdb enable this check"
  default     = false
}

variable "create_gremlin" {
  type        = bool
  description = "If you want to create Gremlin api for cosmosdb enable this check"
  default     = false
}

variable "project_name_prefix" {
  description = "Used in tags cluster and nodes"
  type        = string
  default     = "Azure_cosmmosdb"
}

variable "default_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    "Scope" : "Cosmosdb"
    "CreatedBy" : "Terraform"
  }
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    Project    = "Azure_Cosmosdb",
    Managed-By = "TTN",
  }
}

variable "subnet_name" {
  description = "name of the subnet"
  type        = string
  default     = "cosmosdb-subnet"
}

variable "vnet_name" {
  description = "name of the virtual network"
  type = string
  default = "vnet1"
}



###################################################################
###                  Cosmosdb account                           ###
###################################################################

variable "account_name" {
  description = "name of your cosmos account"
  type        = string
  default     = "cosmosdb-mongodb-acc"
}


variable "auto_failover" {
  description = "Whether to enable automatic failover for the Azure Cosmos DB account."
  type        = bool
  default     = false
}

variable "free_tier" {
  description = "Whether to create the Azure Cosmos DB account in the free tier"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether to allow public access to the Azure Cosmos DB account"
  type        = bool
  default     = false
}

variable "multi_region_write" {
  description = "Enable multiple write locations for this Cosmos DB account"
  type        = bool
  default     = false
}


variable "consistency_level" {
  description = "The consistency level for the Cosmos DB account. (strong , eventual , boundedStaleness)"
  default     = "BoundedStaleness"
}

variable "max_interval_in_seconds" {
  description = "The maximum interval in seconds for the Bounded Staleness consistency level."
  type        = number
  default     = 300
}

variable "max_staleness_prefix" {
  description = "The maximum number of stale requests tolerated for the Bounded Staleness consistency level. "
  type        = number
  default     = 100000
}

variable "consistency_policy" {
  type = object({
    consistency_level       = string
    max_interval_in_seconds = number
    max_staleness_prefix    = number
  })
   default = {
    consistency_level       = "Eventual"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
   }  
}


variable "capabilities" {
  type        = list(string)
  description = "Map of non-sql DB API to enable support for API other than SQL"
  default = [
     "EnableMongo",
     "EnableCassandra",
     "EnableTable",
     "EnableGremlin",
  ]
}

variable "additional_capabilities" {
  type        = list(string)
  description = "List of additional capabilities for Cosmos DB API. - possible options are DisableRateLimitingResponses, EnableAggregationPipeline, EnableServerless, mongoEnableDocLevelTTL, MongoDBv3.4, AllowSelfServeUpgradeToMongo36"
  default     = []
}

variable "geo_locations" {
  description = "List of map of geo locations and other properties to create primary and secodanry databasees."
  type        = any
  default = [
    {
      geo_location      = "eastus"
      failover_priority = 0
      zone_redundant    = false
    },
  ]
}

variable "backup_enabled" {
  type        = bool
  description = "Enable backup for this Cosmos DB account"
  default     = true
}

variable "backup_type" {
  type        = string
  description = "Type of backup - can be either Periodic or Continuous"
  default     = "Periodic"
}

variable "backup_interval" {
  type        = string
  description = "The interval in minutes between two backups. This is configurable only when type is Periodic. Possible values are between 60 and 1440."
  default     = 60
}

variable "backup_retention" {
  type        = string
  description = "The time in hours that each backup is retained. This is configurable only when type is Periodic. Possible values are between 8 and 720."
  default     = 8
}

variable "storage_redundancy" {
  type        = string
  description = "he storage redundancy which is used to indicate type of backup residency. This is configurable only when type is Periodic. Possible values are Geo, Local and Zone"
  default     = "Geo"
}

variable "throughput" {
  type    = number
  default = 4000
}

variable "enable_automatic_failover" {
  type = bool
  default = true
}


variable "allowed_cidrs" {
  description = "List of allowed CIDR ranges"
  type        = list(string)
  default     = ["10.0.0.1"]  # Default to allow all traffic, change as needed
}

variable "is_virtual_network_filter_enabled" {
  description = "Enable virtual network filter"
  type        = bool
  default     = false  # Disable virtual network filter by default
}

variable "network_acl_bypass_for_azure_services" {
  description = "Network ACL bypass for Azure services"
  type        = bool
  default     = false  # Disable bypass for Azure services by default
}

variable "network_acl_bypass_ids" {
  description = "List of Network ACL bypass IDs"
  type        = list(string)
  default     = []  # Default to an empty list, change as needed
}

variable "virtual_network_rule" {
  description = "Specifies a virtual_network_rules resource used to define which subnets are allowed to access this CosmosDB account"
  type = list(object({
    id                                   = string,
    ignore_missing_vnet_service_endpoint = bool
  }))
  default = null
}

variable "identity" {
  type =  string
  default = "SystemAssigned"
}


variable "analytical_storage" {
  description = "Analytical storage enablement."
  type = object({
    enabled     = bool
    schema_type = string
  })

  default = {
    enabled     = false
    schema_type = "FullFidelity"
  }
}

###################################################################
###                    MONGODB                                  ###
###################################################################

variable "db_name" {
  description = "name of your database"
  type        = string
  default     = "mydb"
}

 variable "mongo_db" {
   type = object({
     throughput = number
     max_throughput = number
   })

   default = {
     throughput = 400
     max_throughput = 1000
   }
 }


variable "mongo_db_collections" {
    description = "List of Cosmos DB Mongo collections to create. Some parameters are inherited from cosmos account."
  type = object({
    collection_name           = string
    default_ttl_seconds       = string
    shard_key                 = string
    collection_throughout     = number
    collection_max_throughput = number
    analytical_storage_ttl    = number
  })

  default     = {
    collection_name           = "collection1"
    default_ttl_seconds       = "777"
    shard_key                 = "uniqueKey"
    collection_throughout     =  400
    collection_max_throughput =  1000
    analytical_storage_ttl    =  -1
  }
}

variable "indexes" {
  description = "Configuration for MongoDB indexes"
  type        = object({
    mongo_index_keys   = list(string)
    mongo_index_unique = bool
  })
  default = {
      mongo_index_keys   = ["_id"]
      mongo_index_unique = true
    }
 }


############################################################################
##                          POSTGRESQL                                    ##
############################################################################

variable "psql_cluster_name" {
  description = "name of your postgresql cluster name"
  type        = string
  default     = "my-postgresql-cluster"

}
variable "admin_login_password" {
  description = "enter your password"
  type        = string
  default     = "admin@123"

}
variable "coordinator_storage_quota_in_mb" {
  description = "name of your database"
  type        = number
  default     = 131072

}

variable "coordinator_public_ip_access_enabled" {
  description = "Is public access enabled on coordinator? Defaults to true"
  type        = bool
  default     = false
}

variable "vcore_count" {
  description = "enter the vCore count for the Azure Cosmos DB for PostgreSQL Cluster."
  type        = number
  default     = 2

}

variable "node_count" {
  description = "The worker node count of the Azure Cosmos DB for PostgreSQL Cluster. Possible value is between 0 and 20 except 1"
  type        = number
  default     = 0

}

variable "psql_version" {
  description = "The major PostgreSQL version on the Azure Cosmos DB for PostgreSQL cluster."
  type        = number
  default     = 15

}

variable "node_server_edition" {
  description = "Node server edition"
  type        = string
  default     = "MemoryOptimized"
}

variable "citus_version" {
  description = "Citus extension version"
  type        = string
  default     = "11.3"
}

variable "ha_enabled" {
  description = "Is high availability enabled?"
  type        = bool
  default     = false
}

variable "enable_maintenance" {
  type = bool
  default = true
}

variable "maintenance_window" {
  description = "Maintenance window configuration."
  type = object({
    day_of_week   = number
    start_hour    = number
    start_minute  = number
  })

  default = {
    day_of_week   = 0      # Default to Sunday (0), change as needed
    start_hour    = 0      # Default start hour (0), change as needed
    start_minute  = 0      # Default start minute (0), change as needed
  }
}


variable "firewallrule_name" {
  description = "name of the firewallrule"
  type        = string
  default     = "firewallrule1"

}

variable "start_ip" {
  description = "enter the starting ip"
  type        = string
  default     = "127.0.1.1"

}

variable "end_ip" {
  description = "enter the ending ip"
  type        = string
  default     = "127.0.1.1"

}


############################################################################
##                          CASSANDRA                                     ##
############################################################################

variable "keyspace_name" {
  description = "enter the keyspace name"
  type        = string
  default     = "cosmos-cassandra-keyspace"
}

variable "keyspace_table" {
  description = "enter the keyspace name"
  type        = string
  default     = "table1"
}

variable "keyspace_max_throughput" {
  description = "Maximum throughput for autoscale for the Cassandra keyspace"
  type        = number
  default     = 5000  # Set your default max autoscale throughput value here
}

variable "partition_key_name" {
  description = "Name of the partition key for the Cassandra table"
  type        = string
  default     =  "test1"  # Set your default value here
}

variable "columns" {
  description = "Column definitions for the Cassandra table"
  type = list(object({
    name = string
    type = string
  }))
  default = [
    {
      name = "test1"
      type = "ascii"
    },
    {
      name = "test2"
      type =  "int"
    }
  ]  # Set your default column definitions here
}


############################################################################
##                              GREMLIN                                   ##
############################################################################

variable "gremlin_db_name" {
  description = "enter the database name"
  type        = string
  default     = "cosmos-gremlin-db"
}

variable "gremlin_max_throughput" {
  type = number
  default = 5000
}


variable "gremlin_graph_config" {
  description = "Configuration for the Gremlin graph"
  type = object({
    graph_name            = string
    partition_key_path    = string
    partition_key_version = number
    default_ttl_seconds   = string
    graph_throughput      = number
    index_policy = object({
      automatic      = bool
      indexing_mode  = string
      included_paths = list(string)
      excluded_paths = list(string)
    })
    conflict_resolution_policy = object({
      mode                     = string
      conflict_resolution_path = string
    })
    unique_key = object({
      paths = list(string)
    })
  })

  default = {
    graph_name            = "tfex-cosmos-gremlin-graph"
    partition_key_path    = "/Example"
    partition_key_version = 1
    default_ttl_seconds   = "86400"  # 1 day TTL (optional)
    graph_throughput      = 400
    # graph_max_throughput  = 1000
    index_policy = {
      automatic      = true
      indexing_mode  = "consistent"
      included_paths = ["/*"]
      excluded_paths = ["/\"_etag\"/?"]
    }
    conflict_resolution_policy = {
      mode                     = "LastWriterWins"
      conflict_resolution_path = "/_ts"
    }
    unique_key = {
      paths = ["/definition/id1", "/definition/id2"]
    }
  }
}


############################################################################
##                              SQL                                       ##
############################################################################

variable "sql_db_name" {
  type    = string
  default = "sql-db"
}

variable "sql_max_throughput" {
  type = number
  default = 5000 
}

variable "cosmosdb_container_config" {
  description = "Configuration for the Cosmos DB SQL container"
  type = object({
    container_name           = string
    partition_key_path       = string
    partition_key_version    = number
    container_throughput     = number
    container_max_throughput = number
    default_ttl              = number
    analytical_storage_ttl   = number
    indexing_policy = object({
      indexing_mode     = string
      included_paths    = list(string)
      excluded_paths    = list(string)
    })
    unique_key = object({
      paths = list(string)
    })
  })

  default = {
    container_name           = "example-container"
    partition_key_path       = "/definition/id"
    partition_key_version    = 1
    container_throughput     = 400
    container_max_throughput = 1000
    default_ttl             = 86400  # 1 day TTL (optional)
    analytical_storage_ttl  = 2592000  # 30 days TTL for analytical storage (optional)
    indexing_policy = {
      indexing_mode  = "consistent"
      included_paths = ["/*"]
      excluded_paths = ["/included/?", "/excluded/?"]
    }
    unique_key = {
      paths = ["/definition/idlong", "/definition/idshort"]
    }
  }
}



############################################################################
##                              TABLE                                     ##
############################################################################

variable "table_name" {
  type    = string
  default = "cosmosdb-table"
}

variable "max_throughput" {
  type    = number
  default = 1000
}

###################################################################
###                private endpoint                             ###
###################################################################
variable "private_dns_zone_name" {
    description = "The name of the private DNS zone for the MariaDB server."
    type        = string
    default     = "privatelink.cosmosdb.mongodb.azure.com"
}

 variable "private_service_connection_name" {
    description = "The name of the private service connection for the MariaDB server."
    type        = string
    default     = "cosmos-db-private-service-connection"
}

variable "private_service_connection_is_manual_connection" {
    description = "Determines if the private service connection is created manually or automatically."
    type        = bool
    default     = false
}

variable "dns_zone_virtual_network_link_name" {
    description = "The name of the virtual network link for the private DNS zone."
    type        = string
    default     = "vnet-private-zone-link"
}
 
 variable "private_endpoint" {
  type = bool
  default = true
   
 }
variable "subresource_name" {
  type = list(string)
  default = ["MongoDB","coordinator","Cassandra","SQL","Table","Gremlin"]
}



