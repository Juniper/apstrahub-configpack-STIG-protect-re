#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

variable "blueprint_id" {
  type        = string
  description = "Blueprint ID where the configuration will be applied"
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.blueprint_id))
    error_message = "Blueprint ID must contain only alphanumeric characters, underscores, and hyphens"
  }
}

variable "name" {
  type        = string
  default     = "STIG protect re"
  description = "Name of the configuration"
  validation {
    condition     = can(regex("^[a-zA-Z0-9\\s_-]+$", var.name))
    error_message = "Name must contain only alphanumeric characters, spaces, underscores, and hyphens"
  }
}

variable "configlet_scope" {
  type        = string
  description = "Selects devices where configlet should be applied. Example: `hostname in [\"spine1\", \"spine2\"]`"
  validation {
    condition     = can(regex("^.+$", var.configlet_scope))
    error_message = "Configlet scope must not be empty"
  }
}

variable "management_nets" {
  type        = list(string)
  description = "IP blocks which will require management access to the network devices in CIDR format, e.g. `192.2.0.64/27`"
  validation {
    condition     = alltrue([for v in var.management_nets : can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", v))])
    error_message = "Each value must be a valid CIDR notation (e.g., 192.168.1.0/24)"
  }
}

variable "radius_servers" {
  type        = list(string)
  description = "IP addresses of RADIUS servers used by the network devices"
  validation {
    condition     = alltrue([for v in var.radius_servers : can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", v))])
    error_message = "Each value must be a valid IP address (e.g., 192.168.1.1)"
  }
}

variable "ntp_servers" {
  type        = list(string)
  description = "IP addresses of NTP servers used by the network devices"
  validation {
    condition     = alltrue([for v in var.ntp_servers : can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", v))])
    error_message = "Each value must be a valid IP address (e.g., 192.168.1.1)"
  }
}

variable "apstra_ip" {
  type        = string
  description = "IP address of Apstra server to be used in security policy"
  validation {
    condition     = can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", var.apstra_ip))
    error_message = "Must be a valid IP address (e.g., 192.168.1.1)"
  }
}