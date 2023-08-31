module "cosmosdb" {
  source                          = "git::https://github.com/gauravnegi01/terraform-azure-cosmosdb.git?ref=cosmosdb-v1"

  create_mongodb                  = false
  create_postgresql               = false
  create_cassandra                = false
  create_table                    = false
  create_sql                      = false
  create_gremlin                  = true
  
  project_name_prefix             = "Azure_cosmmosdb"

  resource_group_name             = "kjnvjnvne_group"
  location_id                     = "WEST US" 
  vnet_name                       = "vnet1"
  subnet_name                     = "mariadb-subnet"
  

  # set public_network_access_enabled = true if you want to enable public access and add allow public in firewall rule
  # by default public_network_access_enabled is false
  # public_network_access_enabled    = true  
  # allowed_cidrs                   = ["61.12.91.218"]

 # set private_endpoint = true if you want cosmosdb to only accessed by private endpoint default is true 
  private_endpoint                 = true

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