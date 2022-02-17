provider "aws" {}

module "kops-seed" {
  source = "../../structs/aws-kops-seed"
  environment = "dev"
  project = "gen6"
  region = "us-east-1"
  zone_name = "us-east-1.dev.gen6bk.com"
}

data "aws_route53_zone" "regional_zone" {
  name = "us-east-1.dev.gen6bk.com"
}

resource "aws_route53_zone" "int_useast1" {
  name = "int.us-east-1.dev.gen6bk.com"
}

resource "aws_route53_record" "int_useast1_record" {
  allow_overwrite = true
  name            = "int"
  ttl             = 30
  type            = "NS"
  zone_id         = data.aws_route53_zone.regional_zone.zone_id

  records = [
    aws_route53_zone.int_useast1.name_servers.0,
    aws_route53_zone.int_useast1.name_servers.1,
    aws_route53_zone.int_useast1.name_servers.2,
    aws_route53_zone.int_useast1.name_servers.3,
  ]
}

resource "aws_route53_zone" "qa_useast1" {
  name = "qa.us-east-1.dev.gen6bk.com"
}

resource "aws_route53_record" "qa_useast1_record" {
  allow_overwrite = true
  name            = "qa"
  ttl             = 30
  type            = "NS"
  zone_id         = data.aws_route53_zone.regional_zone.zone_id

  records = [
    aws_route53_zone.qa_useast1.name_servers.0,
    aws_route53_zone.qa_useast1.name_servers.1,
    aws_route53_zone.qa_useast1.name_servers.2,
    aws_route53_zone.qa_useast1.name_servers.3,
  ]
}


