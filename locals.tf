locals {
  default_tags = {
    env   = var.environment
    stack = var.stack
  }

  name_prefix = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""

  server_name = coalesce(
    var.server_custom_name,
    "${local.name_prefix}${var.stack}-${var.client_name}-${var.location_short}-${var.environment}-sql",
  )
  elastic_pool_name = coalesce(
    var.elastic_pool_custom_name,
    "${local.name_prefix}${var.stack}-${var.client_name}-${var.location_short}-${var.environment}-pool",
  )

  elastic_pool_sku = {
    name     = format("%sPool", var.sku.tier)
    capacity = var.sku.capacity
    tier     = var.sku.tier
  }

  databases_users = var.create_databases_users ? { for db in var.databases_names : db => format("%s_user", replace(db, "-", "_")) } : {}
}
