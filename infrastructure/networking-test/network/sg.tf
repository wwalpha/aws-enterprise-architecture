module "instance_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "instance_sg_${var.suffix}"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
}

module "endpoints_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "endpoints_sg_${var.suffix}"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
}
