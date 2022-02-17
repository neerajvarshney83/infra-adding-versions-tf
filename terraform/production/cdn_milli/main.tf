provider aws {
  region = "us-east-1"
}

module "prod" {
  source      = "../../structs/aws-cdn"
  subdomain   = "assets"
  zone        = "milli-bank.com"
  environment = "prod"
  bucket      = "assets"
}

module "links" {
  source      = "../../structs/aws-cdn"
  subdomain   = "links"
  zone        = "milli-bank.com"
  environment = "prod"
  bucket      = "links"
}
