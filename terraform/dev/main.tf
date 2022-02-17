terraform {
  backend "s3" {
    bucket = "us-east-1-dev-gen6-state"
    key    = "infra/base.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = { version = "~> 3.27"}
  }
}

provider "aws" {
  region = "us-east-1"
}

module "pagerduty" {
  source = "./pagerduty"
}

module "sentry" {
  source = "./sentry"
  sentry_token = var.sentry_token
}

variable "sentry_token" {
  type = string
  description = "Sentry API token"
}

module "guardduty" {
  source         = "../structs/aws-guardduty"
  region         = "us-east-1"
  aws_account_id = "629239191919"
}

module "securityhub" {
  source      = "../structs/aws-securityhub"
  project     = "milli"
  environment = "dev"
}

module "s3logs" {
  source      = "../structs/aws-s3-logs"
  project     = "gen6-dev"
  environment = "int"
}

module "s3logs_qa" {
  source      = "../structs/aws-s3-logs"
  project     = "gen6-dev"
  environment = "qa"
}

resource "aws_iam_saml_provider" "saml" {
  name = "Google"
  saml_metadata_document = file("${path.module}/idp-profile/saml.xml")
}

module "vpn_int" {
  source = "../structs/aws-vpn"
  domain = "gen6bk.com"
  account = "dev"
  environment = "int"
  saml_provider_arn = aws_iam_saml_provider.saml.arn
}
  
module "vpn_qa" {
  source = "../structs/aws-vpn"
  domain = "gen6bk.com"
  account = "dev"
  environment = "qa"
  saml_provider_arn = aws_iam_saml_provider.saml.arn
}

module "cdn" {
  source = "./cdn"
}

module "aws-iam-policies" {
  source = "./aws-iam-policies"
}

module "cloudtrail" {
  source  = "../structs/aws-cloudtrail"
  project = "gen6-dev"
  environment = "int"
}

module "ops_ui" {
  source = "./ops_ui"
}

module "ses" {
  source = "../structs/aws-ses"
  domain = "milli-bank.com"
}

module "rds_int" {
  source          = "./rds"
  master_username = "gen6_user"
  cluster_dns     = "int.us-east-1.dev.gen6bk.com"
}

module "rds_qa" {
  source          = "./rds"
  master_username = "gen6_user"
  cluster_dns     = "qa.us-east-1.dev.gen6bk.com"
}

module "elasticache_int" {
  source      = "./elasticache"
  cluster_dns = "int.us-east-1.dev.gen6bk.com"
}

module "elasticache_qa" {
  source      = "./elasticache"
  cluster_dns = "qa.us-east-1.dev.gen6bk.com"
}

module "app_file_storage_int" {
  environment = "int"
  source = "./app_file_storage"
}

module "app_file_storage_qa" {
  environment = "qa"
  source = "./app_file_storage"
}

module "aws-iam-role" {
  source      = "../structs/aws-iam-role"
  namespace   = "milli"
  stage       = "dev"
}

module "password_managementn" {
  source = "../structs/aws-iam-user-password-management"
}

module "albiam" {
  source = "../structs/aws-iam-policy-loadbalancer"
}
