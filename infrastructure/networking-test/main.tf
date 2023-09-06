terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.0.0"
      configuration_aliases = [aws]
    }
  }
}

module "env1" {
  source               = "./network"
  suffix               = "env1"
  vpc_cidr             = "10.1.0.0/16"
  vpc_private_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
  amazon_linux_ami_id  = var.amazon_linux_ami_id
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
}

module "env2" {
  source               = "./network"
  suffix               = "env2"
  vpc_cidr             = "10.2.0.0/16"
  vpc_private_subnets  = ["10.2.1.0/24", "10.2.2.0/24"]
  amazon_linux_ami_id  = var.amazon_linux_ami_id
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
}
