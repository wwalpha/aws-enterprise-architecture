# ----------------------------------------------------------------------------------------------
# AWS VPC
# ----------------------------------------------------------------------------------------------
resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "dmz-vpc"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Internet Gateway
# ----------------------------------------------------------------------------------------------
resource "aws_internet_gateway" "this" {
  tags = {
    Name = "dmz-igw"
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Internet Gateway Attachment
# ----------------------------------------------------------------------------------------------
resource "aws_internet_gateway_attachment" "this" {
  internet_gateway_id = aws_internet_gateway.this.id
  vpc_id              = aws_vpc.this.id
}
