provider aws {
  region = "us-east-1"
}

module "int" {
  source      = "./ui"
}

module "qa" {
  source      = "./ui"
}
