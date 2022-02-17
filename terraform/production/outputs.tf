output "endpoint" {
  value       = module.aurora_db.endpoint
  description = "The endpoint for the db"
}

output "temp_password" {
  value       = module.aurora_db.temp_password
  description = "The initial random temp password"
  sensitive   = true
}

output "configuration_endpoint" {
  value       = module.elasticache.configuration_endpoint
  description = "The configuration endpoint"
}
output "primary_endpoint" {
  value       = module.elasticache.primary_endpoint
  description = "The primary endpoint"
}
