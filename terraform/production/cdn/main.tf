provider aws {
  region = "us-east-1"
}

module "prod" {
  source      = "../../structs/aws-cdn"
  subdomain   = "assets"
  zone        = "enva.gen6bk.com"
  environment = "prod"
  bucket      = "gen6-prod-assets"
}
