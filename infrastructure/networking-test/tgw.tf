# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway VPC Attachment - App1 VPC
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_vpc_attachment" "app1" {
  subnet_ids                                      = [module.env1.subnet_ids[0]]
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  transit_gateway_id                              = var.transit_gateway_id
  vpc_id                                          = module.env1.vpc_id
  tags                                            = { Name = "app1-attachment" }
}

# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway Route Table - App1 VPC
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_route_table" "app1" {
  transit_gateway_id = var.transit_gateway_id
  tags = {
    Name = "app1-tgw-rt"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway Route Table Association - App1 VPC
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_route_table_association" "app1" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.app1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app1.id
}

# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway Route - App1 to App2 
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_route" "app1_to_app2" {
  destination_cidr_block         = module.env2.vpc_cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.app2.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app1.id
}

# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway Route Table - App2 VPC
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_route_table" "app2" {
  transit_gateway_id = var.transit_gateway_id
  tags = {
    Name = "app2-tgw-rt"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway VPC Attachment - App2 VPC
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_vpc_attachment" "app2" {
  subnet_ids                                      = [module.env2.subnet_ids[0]]
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  transit_gateway_id                              = var.transit_gateway_id
  vpc_id                                          = module.env2.vpc_id
  tags = {
    Name = "app2-attachment"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway Route Table Association - App2 VPC
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_route_table_association" "app2" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.app2.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app2.id
}

# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway Route - App2 to App1 
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_route" "app2_to_app1" {
  destination_cidr_block         = module.env1.vpc_cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.app1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app2.id
}
