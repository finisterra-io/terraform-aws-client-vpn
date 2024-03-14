variable "enabled" {
  type        = bool
  description = "Set to `true` to enable the MSK cluster"
  default     = true
}

variable "authentication_options" {
  type = object({
    type                           = string
    active_directory_id            = optional(string)
    root_certificate_chain_arn     = optional(string)
    saml_provider_arn              = optional(string)
    self_service_saml_provider_arn = optional(string)
  })
  description = "A map of authentication options"
  default     = null
}

variable "client_cidr_block" {
  type        = string
  description = "The IPv4 address range, in CIDR notation, from which to assign client IP addresses"
  default     = null
}

variable "client_connect_options" {
  type = object({ enabled = bool,
    lambda_function_arn = optional(string)
  })
  description = "A map of client connect options"
  default     = null
}

variable "client_login_banner_options" {
  type = object({ enabled = bool,
    banner_text = optional(string)
  })
  description = "A map of client login banner options"
  default     = null
}

variable "connection_log_options" {
  type = object({ enabled = bool,
    cloudwatch_log_group  = optional(string),
    cloudwatch_log_stream = optional(string)
  })
  description = "A map of connection log options"
  default     = null
}

variable "description" {
  type        = string
  description = "A brief description of the Client VPN endpoint"
  default     = null
}

variable "dns_servers" {
  type        = list(string)
  description = "A list of DNS servers to be used by the client VPN endpoint"
  default     = null
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to apply to the target network"
  default     = null
}

variable "self_service_portal" {
  type        = string
  description = "Set to `enabled` to enable the self-service portal"
  default     = null
}

variable "server_certificate_arn" {
  type        = string
  description = "The ARN of the server certificate"
  default     = null
}

variable "session_timeout_hours" {
  type        = number
  description = "The number of minutes after which a client session is terminated"
  default     = null
}

variable "split_tunnel" {
  type        = bool
  description = "Set to `enabled` to enable split tunneling"
  default     = null
}

variable "transport_protocol" {
  type        = string
  description = "The transport protocol to be used by the client VPN endpoint"
  default     = null
}

variable "vpn_port" {
  type        = number
  description = "The port number to assign to the client VPN endpoint for TCP and UDP traffic"
  default     = null
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "network_association_subnet_names" {
  type        = list(string)
  description = "A list of subnet names to associate with the client VPN endpoint"
  default     = null
}

variable "network_association_subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to associate with the client VPN endpoint"
  default     = null
}


variable "authorization_rules" {
  type = list(object({
    target_network_cidr  = string
    access_group_id      = optional(string)
    authorize_all_groups = optional(bool)
    description          = optional(string)
  }))
  description = "A map of authorization rules"
  default     = []
}

variable "routes" {
  type = list(object({
    destination_cidr_block = string
    target_vpc_subnet_id   = optional(string)
    target_vpc_subnet_name = optional(string)
    description            = optional(string)
  }))
  description = "A map of routes"
  default     = []
}
