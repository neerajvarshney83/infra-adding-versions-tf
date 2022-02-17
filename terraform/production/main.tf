terraform {
  backend "s3" {
    bucket = "us-east-1-prod-milli-state"
    key    = "infra/base.tfstate"
    region = "us-east-1"
  }
}

data "aws_route53_zone" "milli" {
  name = "milli-bank.com"
}

resource "aws_route53_zone" "milli_prod" {
  name = "prod.milli-bank.com"
}

resource "aws_route53_record" "milli_prod" {
  allow_overwrite = true
  name            = "prod.milli-bank.com"
  ttl             = 30
  type            = "NS"
  zone_id         = data.aws_route53_zone.milli.zone_id

  records = [
    aws_route53_zone.milli_prod.name_servers.0,
    aws_route53_zone.milli_prod.name_servers.1,
    aws_route53_zone.milli_prod.name_servers.2,
    aws_route53_zone.milli_prod.name_servers.3,
  ]
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "cluster_vpc" {
  filter {
    name   = "tag:Name"
    values = ["us-east-1.prod.milli-bank.com"]
  }
}

module "guardduty" {
  source         = "../structs/aws-guardduty"
  region         = "us-east-1"
  aws_account_id = "850315125037"
}

module "securityhub" {
  source      = "../structs/aws-securityhub"
  project     = "milli"
  environment = "prod"
}

module "pagerduty" {
  source = "./pagerduty"
}

module "aws-iam-policies" {
  source = "./aws-iam-policies"
}

data "aws_subnet_ids" "cluster_subnet_ids" {
  vpc_id = data.aws_vpc.cluster_vpc.id

  tags = {
    cluster = "mino-prod"
  }
}

data "aws_subnet" "cluster_subnets" {
  for_each = data.aws_subnet_ids.cluster_subnet_ids.ids
  id       = each.value
}

resource "aws_iam_saml_provider" "saml" {
  name = "Google"
  saml_metadata_document = file("${path.module}/idp-profile/saml.xml")
}

module "vpn" {
  source = "../structs/aws-vpn"
  domain = "milli-bank.com"
  account = "prod"
  environment = "prod"
  saml_provider_arn = aws_iam_saml_provider.saml.arn
}

module "ses" {
  source = "../structs/aws-ses"
  domain = "milli-bank.com"
}

module "s3logs" {
  source      = "../structs/aws-s3-logs"
  project     = "gen6-prod"
  environment = "prod"
}


module "elasticache" {
  source = "../structs/aws-elasticache"

  name                = "gen6prod"
  vpc_id              = data.aws_vpc.cluster_vpc.id
  ingress_cidr_blocks = [for s in data.aws_subnet.cluster_subnets : s.cidr_block]
  shards              = 1
  cache_subnet_confs = {
    subnet_a = {
      cidr = "10.0.151.0/24"
      az   = "us-east-1a"
    },
    subnet_b = {
      cidr = "10.0.152.0/24"
      az   = "us-east-1b"
    },
    subnet_c = {
      cidr = "10.0.153.0/24"
      az   = "us-east-1c"
    }
  }
}

module "cloudtrail" {
  source  = "../structs/aws-cloudtrail-prev"
  project = "gen6-prod"
}

module "aurora_db" {
  source = "../structs/aws-aurora_serverless"

  name                = "gen6prod"
  vpc_id              = data.aws_vpc.cluster_vpc.id
  ingress_cidr_blocks = [for s in data.aws_subnet.cluster_subnets : s.cidr_block]
  master_username     = "gen6_user"
  max_capacity        = 32
  min_capacity        = 16
  db_subnet_confs = {
    subnet_a = {
      cidr = "10.0.20.0/24"
      az   = "us-east-1a"
    },
    subnet_b = {
      cidr = "10.0.21.0/24"
      az   = "us-east-1b"
    },
    subnet_c = {
      cidr = "10.0.22.0/24"
      az   = "us-east-1c"
    }
  }
}

module "ops_ui" {
  source = "./ops_ui"
}

module "cdn" {
  source = "./cdn"
}

module "cdn_milli" {
  source = "./cdn_milli"
}

module "aws-iam-role" {
  source      = "../structs/aws-iam-role"
  namespace   = "milli"
  stage       = "prod"
}
