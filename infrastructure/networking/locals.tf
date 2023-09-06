locals {
  firewall_endpoints = flatten(aws_networkfirewall_firewall.this.firewall_status[*].sync_states[*].*.attachment[*])[*].endpoint_id
  # firewall_subnet_ids = flatten(aws_networkfirewall_firewall.this.firewall_status[*].sync_states[*].*.attachment[*])[*].subnet_id
  # firewall_zones      = { for obj in flatten(aws_networkfirewall_firewall.this.firewall_status[*].sync_states[*].*) : obj.availability_zone => obj.attachment[0].endpoint_id }

  availability_zones = ["us-east-1a", "us-east-1c"]

  public_subnets_cidr_block     = ["10.0.0.0/24", "10.0.1.0/24"]
  network_fw_subnets_cidr_block = ["10.0.2.0/24", "10.0.3.0/24"]
  transit_gw_subnets_cidr_block = ["10.0.4.0/24", "10.0.5.0/24"]
}
