
terraform {
  backend "s3" {
    bucket = "us-east-1-prod-milli-state"
    key    = "infra/prod-app-provisioning.tfstate"
    region = "us-east-1"
  }
}

locals {
  db_hostname        = "gen6prod.cluster-cep1en8vhbzn.us-east-1.rds.amazonaws.com"
  dev_aws_account_id = "629239191919"
}

module "example_ecr" {
  source                           = "../../modules/ecr-repository"
  repository_name                  = "mino-example"
  additional_aws_account_access_id = local.dev_aws_account_id
}

module "example_database" {
  source            = "../../modules/database-setup"
  app_username      = "example"
  db_host           = local.db_hostname
  db_owner_password = var.database_owner_password
}

module "mino-plaid-mock_ecr" {
  source                           = "../../modules/ecr-repository"
  repository_name                  = "mino-plaid-mock"
  additional_aws_account_access_id = local.dev_aws_account_id
}

module "mino-helios_ecr" {
  source                           = "../../modules/ecr-repository"
  repository_name                  = "mino-helios"
  additional_aws_account_access_id = local.dev_aws_account_id
}
