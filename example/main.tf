module "create_cosmosdb" {
  source                          = "git::https://github.com/gauravnegi100/cosmosdb_modules.git"

  create_mongodb                  = false
  create_postgresql               = false
  create_cassandra                = false
  create_table                    = false
  create_sql                      = false
  create_gremlin                  = false
  
  project_name_prefix             = "Azure_cosmmosdb"

  resource_group_name             = "cosmosdb-rg"
  location                        = "EAST US 2" 
  vnet_name                       = "myvnet"
  subnet_name                     = "cosmosdb-subnet"
  

 geo_locations = [
    {
      geo_location      = "eastus"
      failover_priority = 0
      zone_redundant    = false
    },
  ]

backup_enabled   = true
backup_type = "Periodic"    
backup_interval = 60
backup_retention = 8
storage_redundancy = "Geo"


consistency_policy = {
    consistency_level       = "Eventual"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }  

analytical_storage = {
    enabled     = false
    schema_type = "FullFidelity"
  }
}