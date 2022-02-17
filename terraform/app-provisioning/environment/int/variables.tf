
variable "github_token" {
  type = string
  description = "GitHub API token"
}

variable "sentry_token" {
  type = string
  description = "API token for Sentry"
}

variable "int_database_owner_password" {
  type = string
  description = "The password of the database owner"
}
