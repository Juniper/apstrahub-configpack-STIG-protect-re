resource "apstra_property_set" "a" {
  name = var.name
  data = jsonencode(merge(
    {
      mgmt_network = join(",", var.management_nets),
      apstra_svr   = var.apstra_ip
    },
    { for i in range(length(var.radius_servers)) : format("radius_svr_%d", i) => sort(var.radius_servers)[i] },
    { for i in range(length(var.ntp_servers)) : format("ntp_svr_%d", i) => sort(var.ntp_servers)[i] },
    )
  )
}

resource "apstra_datacenter_property_set" "a" {
  blueprint_id      = var.blueprint_id
  id                = apstra_property_set.a.id
  sync_with_catalog = true
}