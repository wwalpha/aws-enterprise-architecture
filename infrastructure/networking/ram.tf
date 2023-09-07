# ----------------------------------------------------------------------------------------------
# AWS Resource Access Manager Resource Share
# ----------------------------------------------------------------------------------------------
resource "aws_ram_resource_share" "tgw" {
  name = "shared-tgw-with-org"
}

# ----------------------------------------------------------------------------------------------
# AWS Resource Access Manager Resource Share
# ----------------------------------------------------------------------------------------------
resource "aws_ram_principal_association" "tgw" {
  principal          = var.org_arn
  resource_share_arn = aws_ram_resource_share.tgw.arn
}

# ----------------------------------------------------------------------------------------------
# AWS RAM Resource Association
# ----------------------------------------------------------------------------------------------
resource "aws_ram_resource_association" "tgw" {
  resource_arn       = aws_ec2_transit_gateway.this.arn
  resource_share_arn = aws_ram_resource_share.tgw.arn
}
