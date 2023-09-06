variable "suffix" {}

variable "vpc_private_subnets" {
  type = list(string)
}

variable "vpc_cidr" {}

variable "amazon_linux_ami_id" {}

variable "iam_instance_profile" {}