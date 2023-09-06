# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway" "this" {
  description                     = "Shared Transit Gateway"
  vpn_ecmp_support                = "disable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  auto_accept_shared_attachments  = "disable"
}

# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway Route Table
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_route_table" "dmz" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
}

# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway VPC Attachment - DMZ VPC
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_vpc_attachment" "dmz" {
  subnet_ids                                      = aws_subnet.transit_gw[*].id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  transit_gateway_id                              = aws_ec2_transit_gateway.this.id
  vpc_id                                          = aws_vpc.dmz.id
  tags                                            = { Name = "dmz-vpc-attachment" }
}

# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway Route Table Association - DMZ VPC
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_route_table_association" "dmz" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.dmz.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.dmz.id
}

# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway Route Table Propagation - DMZ VPC
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_route_table_propagation" "dmz" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.dmz.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.dmz.id
}

# ----------------------------------------------------------------------------------------------
# AWS Route - DMZ VPC
# ----------------------------------------------------------------------------------------------
# resource "aws_route" "to-trgw1" {
#   route_table_id         = aws_route_table.routetable1.id
#   transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
#   destination_cidr_block = "10.222.0.0/16"
# }
