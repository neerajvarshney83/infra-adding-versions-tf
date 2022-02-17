variable "master_username" {
  default = "gen6_user"
}

variable "cluster_dns" {
  default = "int.dev.gen6bk.com"
}

data "aws_vpc" "cluster_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.cluster_dns]
  }
}

data "aws_subnet_ids" "cluster_subnet_ids" {
  vpc_id = data.aws_vpc.cluster_vpc.id

  tags = {
    KubernetesCluster = var.cluster_dns
  }
}

data "aws_subnet" "cluster_subnets" {
  for_each = data.aws_subnet_ids.cluster_subnet_ids.ids
  id       = each.value
}

module "aurora_db" {
  source = "../../structs/aws-aurora_serverless"

  name                = join("-", slice(split(".", var.cluster_dns), 0, 2))
  vpc_id              = data.aws_vpc.cluster_vpc.id
  ingress_cidr_blocks = [for s in data.aws_subnet.cluster_subnets : s.cidr_block]
  master_username     = var.master_username
  max_capacity        = 32
  db_subnet_confs = {
    subnet_a = {
      cidr = "172.20.128.0/24"
      az   = "us-east-1a"
    },
    subnet_b = {
      cidr = "172.20.129.0/24"
      az   = "us-east-1b"
    },
    subnet_c = {
      cidr = "172.20.130.0/24"
      az   = "us-east-1c"
    }
  }
}

