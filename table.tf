resource "azurerm_cosmosdb_table" "table" {
  count               = var.create_table ? 1 : 0
  name                = var.table_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_acc.0.name
  
  /*The max_throughput parameter is used for configuring autoscaling on the table,
   while the throughput block is used for specifying the provisioned throughput for the table.*/
 
  autoscale_settings {
    max_throughput    = var.max_throughput
  }
   
}



  