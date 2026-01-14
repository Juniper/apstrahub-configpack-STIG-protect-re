#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

variable "blueprint_id" {
  type = string
}

variable "name" {
  type    = string
  default = "STIG protect re"
  description = <<-EOF
    {
      "description": "Name of the RE protection configuration profile",
      "display_name": "Profile Name",
      "validators": [
        {
          "args": {
            "min": 1
          },
          "error": "Name must be a non-empty string",
          "type": "string_length"
        }
      ]
    }
  EOF
}

variable "configlet_scope" {
  type = string
  description = <<-EOF
    {
      "description": "Expression defining which devices the configlet should be applied to",
      "display_name": "Configlet Scope",
      "validators": [
        {
          "args": {
            "min": 1
          },
          "error": "Configlet scope must be a non-empty string expression",
          "type": "string_length"
        }
      ]
    }
  EOF
}

variable "management_nets" {
  type = list(string)
  description = <<-EOF
    {
      "description": "IP blocks requiring management access to the network devices, in CIDR notation",
      "display_name": "Management Networks",
      "validators": [
        {
          "args": {
            "validators": [
              {
                "args": {
                  "pattern": "^((22[0-3]|2[0-1][0-9]|1[0-9]{2}|[1-9]?[0-9])(\\.)){3}(22[0-3]|2[0-1][0-9]|1[0-9]{2}|[1-9]?[0-9])/(3[0-2]|[12]?[0-9])$"
                },
                "error": "Each management network must be a valid IPv4 unicast CIDR block",
                "type": "string_regex"
              }
            ]
          },
          "error": "Invalid management network",
          "type": "list_item_string_validators"
        }
      ]
    }
  EOF
}

variable "radius_servers" {
  type = list(string)
  description = <<-EOF
    {
      "description": "IP addresses of RADIUS servers used by the network devices",
      "display_name": "RADIUS Servers",
      "validators": [
        {
          "args": {
            "validators": [
              {
                "args": {
                  "pattern": "^((22[0-3]|2[0-1][0-9]|1[0-9]{2}|[1-9]?[0-9])(\\.)){3}(22[0-3]|2[0-1][0-9]|1[0-9]{2}|[1-9]?[0-9])$"
                },
                "error": "Each RADIUS server must be a valid IPv4 unicast address",
                "type": "string_regex"
              }
            ]
          },
          "error": "Invalid RADIUS server",
          "type": "list_item_string_validators"
        }
      ]
    }
  EOF
}

variable "ntp_servers" {
  type = list(string)
  description = <<-EOF
    {
      "description": "IP addresses of NTP servers used by the network devices",
      "display_name": "NTP Servers",
      "validators": [
        {
          "args": {
            "validators": [
              {
                "args": {
                  "pattern": "^((22[0-3]|2[0-1][0-9]|1[0-9]{2}|[1-9]?[0-9])(\\.)){3}(22[0-3]|2[0-1][0-9]|1[0-9]{2}|[1-9]?[0-9])$"
                },
                "error": "Each NTP server must be a valid IPv4 unicast address",
                "type": "string_regex"
              }
            ]
          },
          "error": "Invalid NTP server",
          "type": "list_item_string_validators"
        }
      ]
    }
  EOF
}

variable "apstra_ip" {
  type = string
  description = <<-EOF
    {
      "description": "IP address of the Apstra server used in the security policy",
      "display_name": "Apstra Server IP",
      "validators": [
        {
          "args": {
            "pattern": "^((22[0-3]|2[0-1][0-9]|1[0-9]{2}|[1-9]?[0-9])(\\.)){3}(22[0-3]|2[0-1][0-9]|1[0-9]{2}|[1-9]?[0-9])$"
          },
          "error": "Apstra IP must be a valid IPv4 unicast address",
          "type": "string_regex"
        }
      ]
    }
  EOF
}
 