terraform {
  backend "s3" {
    bucket = "us-east-1-dev-gen6-state"
    key    = "infra/int-app-provisioning.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = { version = "~> 3.27"}
  }
}

module "mino-plaid-mock_ecr" {
  source                           = "../../modules/ecr-repository"
  repository_name                  = "mino-plaid-mock"
  additional_aws_account_access_id = local.dev_aws_account_id
}
locals {
  db_hostname = "int-us-east-1.cluster-cbjq3tjwvqw1.us-east-1.rds.amazonaws.com"
  dev_aws_account_id = "629239191919"
}

module "example_github" {
  source = "../../modules/github-repository"
  github_token = var.github_token
  repository_description = "mino-example"
  repository_name = "mino-example"
}

module "example_sentry" {
  source = "../../modules/sentry-project"
  sentry_token = var.sentry_token
  project_name = "mino-example"
}

module "example_database" {
  source = "../../modules/database-setup"
  app_username = "example"
  db_host = local.db_hostname
  db_owner_password = var.int_database_owner_password
}


module "ms-finxact-inbound-gateway_sentry" {
  source = "../../modules/sentry-project"
  sentry_token = var.sentry_token
  project_name = "ms-finxact-inbound-gateway"
}

module "mino-plaid-mock_sentry" {
  source = "../../modules/sentry-project"
  sentry_token = var.sentry_token
  project_name = "mino-plaid-mock"
}

module "mino-plaid-mock_database" {
  source = "../../modules/database-setup"
  app_username = "plaidmock"
  db_host = local.db_hostname
  db_owner_password = var.int_database_owner_password
}
  
module "mino-helios_sentry" {
  source = "../../modules/sentry-project"
  sentry_token = var.sentry_token
  project_name = "mino-helios"
}
