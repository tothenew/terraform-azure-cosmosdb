output "endpoint" {
  value = module.database_main.endpoint
}

output "reader_endpoint" {
  value = module.cosmosdb.reader_endpoint
}

output "writer_endpoint" {
  value = module.cosmosdb.writer_endpoint
}

