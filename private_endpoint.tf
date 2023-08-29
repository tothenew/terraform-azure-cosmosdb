resource "azurerm_private_endpoint" "pep" {
  count               = var.private_endpoint ? 1 : 0
  name                = format("%s-private-endpoint", var.account_name)
  location            = data.azurerm_virtual_network.vnet.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = data.azurerm_subnet.cosmos_db_subnet.id


  private_service_connection {
    name                           = var.private_service_connection_name
    is_manual_connection           = var.private_service_connection_is_manual_connection
    private_connection_resource_id = var.create_postgresql ? azurerm_cosmosdb_postgresql_cluster.my-cluster.0.id :  azurerm_cosmosdb_account.cosmosdb_acc.0.id 
    subresource_names = compact([
           var.create_mongodb ? var.subresource_name[0] : null,
           var.create_postgresql ? var.subresource_name[1] : null,
           var.create_cassandra ? var.subresource_name[2] : null,
           var.create_sql ? var.subresource_name[3] : null,
           var.create_table ? var.subresource_name[4] : null,
           var.create_gremlin ? var.subresource_name[5] : null
   ])
}

tags = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))

}


resource "azurerm_private_dns_zone" "dnszone_cosmosdb" {
  count               = var.private_endpoint ? 1 : 0
  name                = var.private_dns_zone_name
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
}

resource "azurerm_private_dns_zone_virtual_network_link" "vent_link_cosmosdb" {
  count                 = var.create_mongodb ? 1 : 0
  name                  = var.dns_zone_virtual_network_link_name
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dnszone_cosmosdb.0.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
  
  tags = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
}
