variable "db_owner_password" {
  type = string
  description = "Database login password"
}

variable "app_username" {
  type = string
  description = "The name of the application user to create"
}

variable "db_host" {
  type = string
  description = "DNS name of the database"
}

variable "db_port" {
  type = number
  description = "Optional. Database port number - defaults to 5432"
  default = 5432
}

variable "db_name" {
  type = string
  description = "Optional. Database name - defaults to 'mino'"
  default = "mino"
}

variable "db_owner_username" {
  type = string
  description = "Optional. Database login username - defaults to 'gen6_user'"
  default = "gen6_user"
}


