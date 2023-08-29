output "endpoint" {
    value = var.create_postgresql == false ? azurerm_cosmosdb_account.cosmosdb_acc[0].endpoint : null 
}

output "reader_endpoint" {
    value = var.create_postgresql == false ? azurerm_cosmosdb_account.cosmosdb_acc[0].read_endpoints[0] : null 
}

output "writer_endpoint" {
    value = var.create_postgresql == false ? azurerm_cosmosdb_account.cosmosdb_acc[0].write_endpoints[0] : null 
}

output "connection_string" {
    value = var.create_postgresql == false ? azurerm_cosmosdb_account.cosmosdb_acc[0].connection_strings[0] : null 
}
