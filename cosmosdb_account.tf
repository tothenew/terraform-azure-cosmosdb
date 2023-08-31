resource "azurerm_cosmosdb_account" "cosmosdb_acc" {
  count                         = var.create_postgresql ? 0 : 1
  name                          = var.account_name
  location                      = var.location_id
  resource_group_name           = data.azurerm_resource_group.rg.name
  offer_type                    = "Standard"
  kind                          = var.create_mongodb ? "MongoDB" : "GlobalDocumentDB"
  public_network_access_enabled = var.public_network_access_enabled

  enable_automatic_failover       = var.enable_automatic_failover
  enable_free_tier                = var.free_tier
  enable_multiple_write_locations = var.multi_region_write

  consistency_policy {
       consistency_level       = var.consistency_policy.consistency_level
       max_interval_in_seconds = var.consistency_policy.max_interval_in_seconds
       max_staleness_prefix    = var.consistency_policy .max_staleness_prefix
}

  dynamic "capabilities" {
     for_each = var.create_sql ? [] : [1]
    content {
      name = coalesce(
           var.create_mongodb ? var.capabilities[0] : null,
           var.create_cassandra ? var.capabilities[1] : null,
           var.create_table ? var.capabilities[2] : null,
           var.create_gremlin ? var.capabilities[3] : null
   )
  }
}

dynamic "analytical_storage" {
    for_each = var.analytical_storage.enabled ? [1] : []
    content {
      schema_type = var.analytical_storage.schema_type
    }
  }

  dynamic "geo_location" {
    for_each = var.geo_locations
    content {
      location          = geo_location.value["geo_location"]
      failover_priority = geo_location.value["failover_priority"]
      zone_redundant    = geo_location.value["zone_redundant"]
    }
  }

  dynamic "backup" {
    for_each = var.backup_enabled == true ? [1] : []    
    content {
      type                = var.backup_type
      interval_in_minutes = var.backup_type == "Periodic" ? var.backup_interval : null
      retention_in_hours  = var.backup_type == "Periodic" ? var.backup_retention : null
      storage_redundancy  = var.backup_type == "Periodic" ? var.storage_redundancy : null
    }
  }

  ip_range_filter = join(",", var.allowed_cidrs)

  is_virtual_network_filter_enabled     = var.is_virtual_network_filter_enabled
  network_acl_bypass_for_azure_services = var.network_acl_bypass_for_azure_services
  network_acl_bypass_ids                = var.network_acl_bypass_ids

  dynamic "virtual_network_rule" {
    for_each = var.virtual_network_rule != null ? toset(var.virtual_network_rule) : []
    content {
      id                                   = data.azurerm_subnet.cosmos_db_subnet.id
      ignore_missing_vnet_service_endpoint = virtual_network_rule.value.ignore_missing_vnet_service_endpoint
    }
  }

  identity {
      type = var.identity
    }
  
  tags = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
}