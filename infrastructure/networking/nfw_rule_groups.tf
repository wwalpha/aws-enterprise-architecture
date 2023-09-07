# ----------------------------------------------------------------------------------------------
# AWS Network Firewall Rule Group - Stateless
# ----------------------------------------------------------------------------------------------
resource "aws_networkfirewall_rule_group" "stateless" {
  capacity = 100
  name     = "nfw-stateless"
  type     = "STATELESS"

  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        stateless_rule {
          priority = 1
          rule_definition {
            actions = ["aws:forward_to_sfe"]

            match_attributes {
              protocols = [6]

              source {
                address_definition = aws_subnet.transit_gw[0].cidr_block
              }
              source_port {
                from_port = 0
                to_port   = 65535
              }
              destination {
                address_definition = "0.0.0.0/0"
              }
              destination_port {
                from_port = 443
                to_port   = 443
              }
            }
          }
        }
        stateless_rule {
          priority = 2

          rule_definition {
            actions = ["aws:drop"]
            match_attributes {
              protocols = [6]
              source {
                address_definition = aws_subnet.transit_gw[1].cidr_block
              }
              source_port {
                from_port = 0
                to_port   = 65535
              }
              destination {
                address_definition = "0.0.0.0/0"
              }
              destination_port {
                from_port = 0
                to_port   = 65535
              }
            }
          }
        }
      }
    }
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Network Firewall Rule Group - Domain Whitelist
# ----------------------------------------------------------------------------------------------
resource "aws_networkfirewall_rule_group" "allow_domain" {
  capacity = 100
  name     = "nfw-allow-domain"
  type     = "STATEFUL"

  rule_group {
    stateful_rule_options {
      rule_order = "DEFAULT_ACTION_ORDER"
    }

    rules_source {
      rules_source_list {
        generated_rules_type = "ALLOWLIST"
        target_types         = ["HTTP_HOST", "TLS_SNI"]
        targets              = [".amazon.com", ".amazonaws.com"]
      }
    }
  }
}
