# ----------------------------------------------------------------------------------------------
# AWS VPC Endpoint - SSM
# ----------------------------------------------------------------------------------------------
resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.private_subnets[0].id
  private_dns_enabled = true
  security_group_ids  = [module.endpoints_sg.security_group_id]

  tags = {
    Name = "ssm_${var.suffix}"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS VPC Endpoint Policy - SSM
# ----------------------------------------------------------------------------------------------
resource "aws_vpc_endpoint_policy" "ssm" {
  vpc_endpoint_id = aws_vpc_endpoint.ssm.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "*",
        "Resource" : "*"
      }
    ]
  })
}

# ----------------------------------------------------------------------------------------------
# AWS VPC Endpoint - EC2Messages
# ----------------------------------------------------------------------------------------------
resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.private_subnets[0].id
  private_dns_enabled = true
  security_group_ids  = [module.endpoints_sg.security_group_id]
  tags = {
    Name = "ec2messages_${var.suffix}"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS VPC Endpoint Policy - EC2Messages
# ----------------------------------------------------------------------------------------------
resource "aws_vpc_endpoint_policy" "ec2messages" {
  vpc_endpoint_id = aws_vpc_endpoint.ec2messages.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "*",
        "Resource" : "*"
      }
    ]
  })
}

# ----------------------------------------------------------------------------------------------
# AWS VPC Endpoint - SSMMessages
# ----------------------------------------------------------------------------------------------
resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.private_subnets[0].id
  private_dns_enabled = true
  security_group_ids  = [module.endpoints_sg.security_group_id]
  tags = {
    Name = "ssmmessages_${var.suffix}"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS VPC Endpoint Policy - SSMMessages
# ----------------------------------------------------------------------------------------------
resource "aws_vpc_endpoint_policy" "ssmmessages" {
  vpc_endpoint_id = aws_vpc_endpoint.ssmmessages.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "*",
        "Resource" : "*"
      }
    ]
  })
}
