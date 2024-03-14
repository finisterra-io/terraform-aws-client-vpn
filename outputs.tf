output "arn" {
  value       = aws_ec2_client_vpn_endpoint.this[0].arn
  description = "The ARN of the Client VPN endpoint"
}
