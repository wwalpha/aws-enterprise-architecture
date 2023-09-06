# ----------------------------------------------------------------------------------------------
# AWS VPC
# ----------------------------------------------------------------------------------------------
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "app-vpc-${var.suffix}"
  cidr                 = var.vpc_cidr
  azs                  = ["us-east-1a", "us-east-1c"]
  private_subnets      = var.vpc_private_subnets
  enable_nat_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true
}
