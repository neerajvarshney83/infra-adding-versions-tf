output "endpoint" {
  value = module.aurora_db.endpoint
  description = "The endpoint for the db"
}
output "temp_username" {
  value = var.master_username
  description = "The initial admin username"
}
output "temp_password" {
  value = module.aurora_db.temp_password
  description = "The initial random temp password"
  sensitive = true
}

