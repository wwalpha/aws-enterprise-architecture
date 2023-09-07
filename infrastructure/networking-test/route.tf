# ----------------------------------------------------------------------------------------------
# AWS Route Table's Route - ALl to Transit Gateway
# ----------------------------------------------------------------------------------------------
resource "aws_route" "app1_to_tgw" {
  route_table_id         = module.env1.private_route_table_ids[0]
  destination_cidr_block = module.env2.vpc_cidr
  transit_gateway_id     = var.transit_gateway_id
}

# ----------------------------------------------------------------------------------------------
# AWS Route Table's Route - ALl to Transit Gateway
# ----------------------------------------------------------------------------------------------
resource "aws_route" "app2_to_tgw" {
  route_table_id         = module.env2.private_route_table_ids[0]
  destination_cidr_block = module.env1.vpc_cidr
  transit_gateway_id     = var.transit_gateway_id
}
