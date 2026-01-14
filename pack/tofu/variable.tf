#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

variable "blueprint_id" {
  type = string
}

variable "name" {
  type = string
  default = "STIG protect re"
}

variable "configlet_scope" {
  type = string
  description = "Selects devices where configlet should be applied. Example: `hostname in [\"spine1\", \"spine2\"]`"
}

variable "management_nets" {
  type = list(string)
  description = "IP blocks which will require management access to the network devices in CIDR format, e.g. `192.2.0.64/27`"
}

variable "radius_servers" {
  type = list(string)
  description = "IP addresses of RADIUS servers used by the network devices"
}

variable "ntp_servers" {
  type = list(string)
  description = "IP addresses of NTP servers used by the network devices"
}

variable "apstra_ip" {
  type = string
  description = "IP address of Apstra server to be used in security policy"
}
