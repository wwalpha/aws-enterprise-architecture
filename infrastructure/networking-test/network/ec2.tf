# ----------------------------------------------------------------------------------------------
# AWS EC2 Instance 
# ----------------------------------------------------------------------------------------------
module "instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = "instance-${var.suffix}"
  ami                    = var.amazon_linux_ami_id
  instance_type          = "t3a.small"
  key_name               = "testing"
  monitoring             = false
  vpc_security_group_ids = [module.instance_sg.security_group_id]
  subnet_id              = module.vpc.private_subnets[0]
  iam_instance_profile   = var.iam_instance_profile
}
