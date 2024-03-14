
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.67 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.67 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_client_vpn_authorization_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_network_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_route) | resource |
| [aws_subnet.association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authentication_options"></a> [authentication\_options](#input\_authentication\_options) | A map of authentication options | <pre>object({<br>    type                           = string<br>    active_directory_id            = optional(string)<br>    root_certificate_chain_arn     = optional(string)<br>    saml_provider_arn              = optional(string)<br>    self_service_saml_provider_arn = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_authorization_rules"></a> [authorization\_rules](#input\_authorization\_rules) | A map of authorization rules | <pre>list(object({<br>    target_network_cidr  = string<br>    access_group_id      = optional(string)<br>    authorize_all_groups = optional(bool)<br>    description          = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_client_cidr_block"></a> [client\_cidr\_block](#input\_client\_cidr\_block) | The IPv4 address range, in CIDR notation, from which to assign client IP addresses | `string` | `null` | no |
| <a name="input_client_connect_options"></a> [client\_connect\_options](#input\_client\_connect\_options) | A map of client connect options | <pre>object({ enabled = bool,<br>    lambda_function_arn = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_client_login_banner_options"></a> [client\_login\_banner\_options](#input\_client\_login\_banner\_options) | A map of client login banner options | <pre>object({ enabled = bool,<br>    banner_text = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_connection_log_options"></a> [connection\_log\_options](#input\_connection\_log\_options) | A map of connection log options | <pre>object({ enabled = bool,<br>    cloudwatch_log_group  = optional(string),<br>    cloudwatch_log_stream = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | A brief description of the Client VPN endpoint | `string` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | A list of DNS servers to be used by the client VPN endpoint | `list(string)` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to `true` to enable the MSK cluster | `bool` | `true` | no |
| <a name="input_network_association_subnet_ids"></a> [network\_association\_subnet\_ids](#input\_network\_association\_subnet\_ids) | A list of subnet IDs to associate with the client VPN endpoint | `list(string)` | `null` | no |
| <a name="input_network_association_subnet_names"></a> [network\_association\_subnet\_names](#input\_network\_association\_subnet\_names) | A list of subnet names to associate with the client VPN endpoint | `list(string)` | `null` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | A map of routes | <pre>list(object({<br>    destination_cidr_block = string<br>    target_vpc_subnet_id   = optional(string)<br>    target_vpc_subnet_name = optional(string)<br>    description            = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of security group IDs to apply to the target network | `list(string)` | `null` | no |
| <a name="input_self_service_portal"></a> [self\_service\_portal](#input\_self\_service\_portal) | Set to `enabled` to enable the self-service portal | `string` | `null` | no |
| <a name="input_server_certificate_arn"></a> [server\_certificate\_arn](#input\_server\_certificate\_arn) | The ARN of the server certificate | `string` | `null` | no |
| <a name="input_session_timeout_hours"></a> [session\_timeout\_hours](#input\_session\_timeout\_hours) | The number of minutes after which a client session is terminated | `number` | `null` | no |
| <a name="input_split_tunnel"></a> [split\_tunnel](#input\_split\_tunnel) | Set to `enabled` to enable split tunneling | `bool` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_transport_protocol"></a> [transport\_protocol](#input\_transport\_protocol) | The transport protocol to be used by the client VPN endpoint | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | `null` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC | `string` | `null` | no |
| <a name="input_vpn_port"></a> [vpn\_port](#input\_vpn\_port) | The port number to assign to the client VPN endpoint for TCP and UDP traffic | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the Client VPN endpoint |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
