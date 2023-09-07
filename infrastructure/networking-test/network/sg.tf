module "instance_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "instance-sg-${var.suffix}"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["all-all"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
}

module "endpoints_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "endpoints-sg-${var.suffix}"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp"]
}
