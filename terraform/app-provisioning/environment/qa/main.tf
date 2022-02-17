terraform {
  backend "s3" {
    bucket = "us-east-1-dev-gen6-state"
    key    = "infra/qa-app-provisioning.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = { version = "~> 3.27"}
  }
}

locals {
  db_hostname = "qa-us-east-1.cluster-cbjq3tjwvqw1.us-east-1.rds.amazonaws.com"
}

module "mino_example_db" {
  source = "../../modules/database-setup"
  app_username = "example"
  db_host = local.db_hostname
  db_owner_password = var.qa_database_owner_password
}
