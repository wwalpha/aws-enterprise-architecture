# ----------------------------------------------------------------------------------------------
# AWS IAM Role
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "ec2_ssm" {
  name               = "EC2_SSMRole_For_Testing"
  assume_role_policy = data.aws_iam_policy_document.ec2.json

  lifecycle {
    create_before_destroy = false
  }
}

# ----------------------------------------------------------------------------------------------
# AWS IAM Role Policy - SSM
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.ec2_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

# ----------------------------------------------------------------------------------------------
# AWS IAM Instance Profile - SSM
# ----------------------------------------------------------------------------------------------
resource "aws_iam_instance_profile" "ec2_ssm" {
  name = "ec2_ssm"
  role = aws_iam_role.ec2_ssm.name
}

