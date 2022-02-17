
provider "postgresql" {
  host            = var.db_host
  port            = var.db_port
  database        = var.db_name
  username        = var.db_owner_username
  password        = var.db_owner_password
  connect_timeout = 15
  superuser       = false
}

resource "postgresql_role" "user" {
  name = var.app_username
  login = true
  encrypted_password = true
  password = var.app_username

}

resource "postgresql_schema" "schema" {
  name = var.app_username
  owner = postgresql_role.user.name
}
