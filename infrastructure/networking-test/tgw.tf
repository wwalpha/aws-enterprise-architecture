# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway VPC Attachment - APP VPC
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_vpc_attachment" "app1" {
  subnet_ids                                      = [module.env1.subnet_ids[0]]
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  transit_gateway_id                              = var.transit_gateway_id
  vpc_id                                          = module.env1.vpc_id
  tags                                            = { Name = "app-vpc1" }
}

# ----------------------------------------------------------------------------------------------
# AWS Transit Gateway VPC Attachment - APP VPC
# ----------------------------------------------------------------------------------------------
resource "aws_ec2_transit_gateway_vpc_attachment" "app2" {
  subnet_ids                                      = [module.env2.subnet_ids[0]]
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  transit_gateway_id                              = var.transit_gateway_id
  vpc_id                                          = module.env2.vpc_id
  tags                                            = { Name = "app-vpc2" }
}
