output "configuration_endpoint" {
  value       = module.elasticache.configuration_endpoint
  description = "The configuration endpoint"
}
output "primary_endpoint" {
  value       = module.elasticache.primary_endpoint
  description = "The primary endpoint"
}
