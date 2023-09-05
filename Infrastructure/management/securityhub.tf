# ----------------------------------------------------------------------------------------------
# Security Hub Organization Configuration
# Auto enable security hub in organization member accounts
# ----------------------------------------------------------------------------------------------
resource "aws_securityhub_organization_configuration" "this" {
  depends_on  = [aws_securityhub_organization_admin_account.this]
  auto_enable = true
}

# ----------------------------------------------------------------------------------------------
# Security Hub
# ----------------------------------------------------------------------------------------------
resource "aws_securityhub_account" "this" {}

# ----------------------------------------------------------------------------------------------
# Security Hub - CIS AWS Foundations Benchmark
# ----------------------------------------------------------------------------------------------
resource "aws_securityhub_standards_subscription" "cis" {
  depends_on    = [aws_securityhub_account.this]
  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
}

# ----------------------------------------------------------------------------------------------
# Security Hub - AWS Foundational Security Best Practices
# ----------------------------------------------------------------------------------------------
resource "aws_securityhub_standards_subscription" "aws" {
  depends_on    = [aws_securityhub_account.this]
  standards_arn = "arn:aws:securityhub:${local.region}::standards/aws-foundational-security-best-practices/v/1.0.0"
}
