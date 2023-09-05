# ----------------------------------------------------------------------------------------------
# Organization
# ----------------------------------------------------------------------------------------------
resource "aws_organizations_organization" "this" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "controltower.amazonaws.com",
    "config.amazonaws.com",
    "member.org.stacksets.cloudformation.amazonaws.com",
    "ram.amazonaws.com",
    "sso.amazonaws.com",
    "securityhub.amazonaws.com",
    "guardduty.amazonaws.com",
    "fms.amazonaws.com",
    "reporting.trustedadvisor.amazonaws.com"
  ]

  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY"
  ]

  feature_set = "ALL"
}

# ----------------------------------------------------------------------------------------------
# Organization Admin Account
# ----------------------------------------------------------------------------------------------
resource "aws_securityhub_organization_admin_account" "this" {
  depends_on = [aws_organizations_organization.this]

  admin_account_id = local.account_id
}
