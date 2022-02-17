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

module "elasticache" {
  source = "../../structs/aws-elasticache"

  name                = join("-", slice(split(".", var.cluster_dns), 0, 2))
  vpc_id              = data.aws_vpc.cluster_vpc.id
  ingress_cidr_blocks = [for s in data.aws_subnet.cluster_subnets : s.cidr_block]
  shards              = 1
  cache_subnet_confs = {
    subnet_a = {
      cidr = "172.20.151.0/24"
      az   = "us-east-1a"
    },
    subnet_b = {
      cidr = "172.20.152.0/24"
      az   = "us-east-1b"
    },
    subnet_c = {
      cidr = "172.20.153.0/24"
      az   = "us-east-1c"
    }
  }
}

