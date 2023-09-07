# ----------------------------------------------------------------------------------------------
# AWS Route Table - Public Subnet
# ----------------------------------------------------------------------------------------------
resource "aws_route_table" "public" {
  count  = length(local.availability_zones)
  vpc_id = aws_vpc.dmz.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  route {
    cidr_block      = aws_subnet.transit_gw[count.index].cidr_block
    vpc_endpoint_id = local.nfw_endpoints[count.index]
  }

  tags = {
    Name = format(
      "dmz_public_rt_%s",
      split("-", element(local.availability_zones, count.index))[2],
    )
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Route Table Association - Public Subnet
# ----------------------------------------------------------------------------------------------
resource "aws_route_table_association" "public" {
  count          = length(local.availability_zones)
  route_table_id = aws_route_table.public[count.index].id
  subnet_id      = aws_subnet.public[count.index].id
}

# ----------------------------------------------------------------------------------------------
# AWS Route Table - Network Firewall Subnet
# ----------------------------------------------------------------------------------------------
resource "aws_route_table" "network_fw" {
  depends_on = [aws_networkfirewall_firewall.this]
  count      = length(local.availability_zones)
  vpc_id     = aws_vpc.dmz.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }

  tags = {
    Name = format(
      "dmz_network_fw_rt_%s",
      split("-", element(local.availability_zones, count.index))[2],
    )
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Route Table Association - Network Firewall Subnet
# ----------------------------------------------------------------------------------------------
resource "aws_route_table_association" "network_fw" {
  count          = length(local.availability_zones)
  route_table_id = aws_route_table.network_fw[count.index].id
  subnet_id      = aws_subnet.network_fw[count.index].id
}

# ----------------------------------------------------------------------------------------------
# AWS Route Table - Transit Gateway Subnet
# ----------------------------------------------------------------------------------------------
resource "aws_route_table" "transit_gw" {
  depends_on = [aws_nat_gateway.this]
  count      = length(local.availability_zones)
  vpc_id     = aws_vpc.dmz.id

  route {
    cidr_block      = "0.0.0.0/0"
    vpc_endpoint_id = local.nfw_endpoints[count.index]
  }

  tags = {
    Name = format(
      "dmz_transit_gw_rt_%s",
      split("-", element(local.availability_zones, count.index))[2],
    )
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Route Table Association - Transit Gateway Subnet
# ----------------------------------------------------------------------------------------------
resource "aws_route_table_association" "transit_gw" {
  count          = length(local.availability_zones)
  route_table_id = aws_route_table.transit_gw[count.index].id
  subnet_id      = aws_subnet.transit_gw[count.index].id
}
