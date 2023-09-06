# ----------------------------------------------------------------------------------------------
# AWS Subnet - Public
# ----------------------------------------------------------------------------------------------
resource "aws_subnet" "public" {
  count             = length(local.availability_zones)
  vpc_id            = aws_vpc.this.id
  cidr_block        = local.public_subnets_cidr_block[count.index]
  availability_zone = local.availability_zones[count.index]

  tags = {
    Name = format(
      "dmz-public-%s",
      element(local.availability_zones, count.index),
    )
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Subnet - Firewall
# ----------------------------------------------------------------------------------------------
resource "aws_subnet" "network_fw" {
  count             = length(local.availability_zones)
  vpc_id            = aws_vpc.this.id
  cidr_block        = local.network_fw_subnets_cidr_block[count.index]
  availability_zone = local.availability_zones[count.index]

  tags = {
    Name = format(
      "dmz-network-fw-%s",
      element(local.availability_zones, count.index),
    )
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Subnet - Private
# ----------------------------------------------------------------------------------------------
resource "aws_subnet" "transit_gw" {
  count             = length(local.availability_zones)
  vpc_id            = aws_vpc.this.id
  cidr_block        = local.transit_gw_subnets_cidr_block[count.index]
  availability_zone = local.availability_zones[count.index]

  tags = {
    Name = format(
      "dmz-transit-gw-%s",
      element(local.availability_zones, count.index),
    )
  }
}
