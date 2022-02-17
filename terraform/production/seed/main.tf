provider "aws" {}

module "kops-seed" {
  source = "../../structs/aws-kops-seed"
  environment = "prod"
  project = "milli"
  region = "us-east-1"
  zone_name = "us-east-1.prod.milli-bank.com"
}
