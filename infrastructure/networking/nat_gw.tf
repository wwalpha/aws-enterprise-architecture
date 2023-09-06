# ----------------------------------------------------------------------------------------------
# AWS Elastic IP
# ----------------------------------------------------------------------------------------------
resource "aws_eip" "this" {
  depends_on = [aws_internet_gateway_attachment.this]
  count      = length(local.availability_zones)

  tags = {
    Name = format(
      "dmz-natgw-eip-%s",
      split("-", element(local.availability_zones, count.index))[2],
    )
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Nat Gateway
# ----------------------------------------------------------------------------------------------
resource "aws_nat_gateway" "this" {
  count         = length(local.availability_zones)
  allocation_id = aws_eip.this[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = format(
      "dmz-natgw-%s",
      split("-", element(local.availability_zones, count.index))[2],
    )
  }
}
