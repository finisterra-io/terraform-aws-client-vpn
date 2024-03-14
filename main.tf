resource "aws_ec2_client_vpn_endpoint" "this" {
  count = var.enabled ? 1 : 0

  authentication_options {
    type                           = try(var.authentication_options["type"], null)
    active_directory_id            = try(var.authentication_options["active_directory_id"], null)
    root_certificate_chain_arn     = try(var.authentication_options["root_certificate_chain_arn"], null)
    saml_provider_arn              = try(var.authentication_options["saml_provider_arn"], null)
    self_service_saml_provider_arn = try(var.authentication_options["self_service_saml_provider_arn"], null)
  }

  client_cidr_block = var.client_cidr_block

  dynamic "client_connect_options" {
    for_each = var.client_connect_options != null ? [var.client_connect_options] : []
    content {
      enabled             = client_connect_options.value["enabled"]
      lambda_function_arn = client_connect_options.value["lambda_function_arn"]
    }
  }

  dynamic "client_login_banner_options" {
    for_each = var.client_login_banner_options != null ? [var.client_login_banner_options] : []
    content {
      enabled     = client_login_banner_options.value["enabled"]
      banner_text = client_login_banner_options.value["banner_text"]
    }
  }

  dynamic "connection_log_options" {
    for_each = var.connection_log_options != null ? [var.connection_log_options] : []
    content {
      enabled               = connection_log_options.value["enabled"]
      cloudwatch_log_group  = connection_log_options.value["cloudwatch_log_group"]
      cloudwatch_log_stream = connection_log_options.value["cloudwatch_log_stream"]
    }
  }

  description            = var.description
  dns_servers            = var.dns_servers
  security_group_ids     = var.security_group_ids
  self_service_portal    = var.self_service_portal
  server_certificate_arn = var.server_certificate_arn
  session_timeout_hours  = var.session_timeout_hours
  split_tunnel           = var.split_tunnel
  tags                   = var.tags
  transport_protocol     = var.transport_protocol
  vpc_id                 = var.vpc_name != null ? data.aws_vpc.default[0].id : var.vpc_id
  vpn_port               = var.vpn_port

}

locals {
  subnet_ids_from_names = { for s in data.aws_subnet.association : s.tags["Name"] => s.id }
  subnet_ids_direct     = { for id in(var.network_association_subnet_ids != null ? var.network_association_subnet_ids : []) : id => id }
  combined_subnet_ids   = merge(local.subnet_ids_from_names, local.subnet_ids_direct)
}

resource "aws_ec2_client_vpn_network_association" "this" {
  for_each = var.enabled ? local.combined_subnet_ids : {}

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this[0].id
  subnet_id              = each.value
}


resource "aws_ec2_client_vpn_authorization_rule" "this" {
  for_each = var.enabled ? { for idx, rule in var.authorization_rules : rule.target_network_cidr => rule } : {}

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this[0].id
  target_network_cidr    = each.value.target_network_cidr
  access_group_id        = try(each.value.access_group_id, null)
  authorize_all_groups   = try(each.value.authorize_all_groups, false)
  description            = try(each.value.description, null)
}


locals {
  routes_with_resolved_subnet_ids = [
    for route in var.routes : {
      description            = route.description
      destination_cidr_block = route.destination_cidr_block
      target_vpc_subnet_id   = route.target_vpc_subnet_id != null ? route.target_vpc_subnet_id : try(data.aws_subnet.route["${route.target_vpc_subnet_name}-${route.destination_cidr_block}"].id, null)
    }
  ]
}

resource "aws_ec2_client_vpn_route" "this" {
  for_each = var.enabled ? { for idx, r in local.routes_with_resolved_subnet_ids : "${r.target_vpc_subnet_id}_${r.destination_cidr_block}" => r } : {}

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this[0].id
  destination_cidr_block = each.value["destination_cidr_block"]
  target_vpc_subnet_id   = each.value["target_vpc_subnet_id"]
  description            = try(each.value["description"], null)

  depends_on = [
    aws_ec2_client_vpn_network_association.this
  ]

  timeouts {
    create = "5m"
    delete = "5m"
  }

}
