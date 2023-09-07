terraform {
  backend "local" {
    path = "./tfstate/terraform.tfstate"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Provider
# ----------------------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

# ----------------------------------------------------------------------------------------------
# AWS Provider
# ----------------------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
  alias  = "Management"

  assume_role {
    role_arn = "arn:aws:iam::381118067369:role/MultiAccountInfraRole"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Provider
# ----------------------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
  alias  = "Networking"

  assume_role {
    role_arn = "arn:aws:iam::769359532219:role/MultiAccountInfraRole"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Provider
# ----------------------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
  alias  = "LogArchive"

  assume_role {
    role_arn = "arn:aws:iam::191026622842:role/MultiAccountInfraRole"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Provider
# ----------------------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
  alias  = "SharedServices"

  assume_role {
    role_arn = "arn:aws:iam::016725430159:role/MultiAccountInfraRole"
  }
}

module "management" {
  source = "./management"
  providers = {
    aws = aws.Management
  }
}

module "networking" {
  source = "./networking"
  providers = {
    aws = aws.Networking
  }
}

# module "networking_test" {
#   source = "./networking-test"
#   providers = {
#     aws = aws.Networking
#   }

#   transit_gateway_id = module.networking.transit_gateway_id
# }
