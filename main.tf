provider "aws" {
  region = var.region
  shared_credentials_files = ["$HOME/.aws/credentials"]
  profile = "devteam"
}

locals {
  cluster_name = "terraform-eks"
}

# resource "random_string" "suffix" {
#   length  = 8
#   special = false
# }

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "terraform-vpc"

  cidr = "10.10.0.0/16"
  azs  = ["ap-northeast-2a","ap-northeast-2c"]

  private_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  public_subnets  = ["10.10.11.0/24", "10.10.12.0/24"]

  enable_nat_gateway   = true
  one_nat_gateway_per_az = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}
output "vpc_id" {
    description = "vpc-id"
    value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
    description = "vpc_cider_block"
    value = module.vpc.vpc_cidr_block
}

output "public_subnets_ids" {
    description = "public_subnets"
    value = module.vpc.public_subnets
}

