provider aws {
  region = "us-east-1"
}

module "int" {
  source      = "../../structs/aws-cdn"
  subdomain   = "assets"
  zone        = "dev.gen6bk.com"
  environment = "int"
  bucket      = "assets.int"
}

module "qa" {
  source      = "../../structs/aws-cdn"
  subdomain   = "assets"
  zone        = "dev.gen6bk.com"
  environment = "qa"
  bucket      = "assets.qa"
}

module "links_int" {
  source      = "../../structs/aws-cdn"
  subdomain   = "links"
  zone        = "dev.gen6bk.com"
  environment = "int"
  bucket      = "links.int"
}

module "links_qa" {
  source      = "../../structs/aws-cdn"
  subdomain   = "links"
  zone        = "dev.gen6bk.com"
  environment = "qa"
  bucket      = "links.qa"
}

