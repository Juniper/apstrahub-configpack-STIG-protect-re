#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

locals {
  t = <<-EOT
    policy-options {
      prefix-list MANAGEMENT {
    {%- for net in mgmt_network.split(',') -%}
      {{ net }};
    {% endfor %}
      }
      prefix-list BGP {
      {% for peer, peer_info in bgp_sessions.items() %}
        {{peer_info.dest_ip}};
      {% endfor %}
      }
      prefix-list RADIUS {
        $${radius_servers}
      }
      prefix-list NTP {
        $${ntp_servers}
      }
      prefix-list APSTRA {
        {{apstra_svr}};
      }
    }
    firewall {
      filter PROTECT-RE {
        term MANAGEMENT_ACCESS {
          from {
            source-prefix-list {
              MANAGEMENT;
            }
            protocol tcp;
            port ssh;
          }
          then {
            accept;
          }
        }
        term APSTRA_MANAGEMENT {
          from {
            source-prefix-list {
              APSTRA;
            }
            protocol tcp;
            port 830;
          }
        }
        term BGP {
          from {
            source-prefix-list {
              BGP;
            }
            protocol tcp;
            port bgp;
          }
          then {
            accept;
          }
        }
        term RADIUS {
          from {
            source-prefix-list {
              RADIUS;
            }
            protocol tcp;
            port radius;
          }
          then {
            accept;
          }
        }
        term NTP {
          from {
            source-prefix-list {
              NTP;
            }
            protocol udp;
            port ntp;
          }
          then {
            accept;
          }
        }
        term DENY_ICMP_FRAG {
          from {
            protocol icmp;
            is-fragment;
          }
          then {
            discard;
          }
        }
        term ICMP {
          from {
            protocol icmp;
          }
          then {
            accept;
          }
        }
        term DENY {
          then {
            discard;
            log;
          }
        }
      }
    }
    interfaces lo0 {
      unit 0 {
        family inet {
          filter {
            input PROTECT-RE;
          }
        }
      }
    }
  EOT
}

resource "apstra_datacenter_configlet" "a" {
  blueprint_id = var.blueprint_id
  name = var.name
  condition = var.configlet_scope
  generators = [
    {
      config_style  = "junos"
      section       = "top_level_hierarchical"
      template_text = templatestring(local.t, {
        radius_servers = join("\n    ", [ for i in range(length(var.radius_servers)) : format("{{radius_svr_%d}}", i)])
        ntp_servers = join("\n    ", [ for i in range(length(var.ntp_servers)) : format("{{ntp_svr_%d}}", i)])
      })
    },
  ]
}
