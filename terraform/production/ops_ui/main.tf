provider aws {
  region = "us-east-1"
}

module "prod" {
  source      = "./ui"
}
