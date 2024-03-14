data "aws_vpc" "default" {
  count = var.enabled && var.vpc_name != null ? 1 : 0
  tags = {
    Name = var.vpc_name
  }
}

data "aws_subnet" "association" {
  count  = var.enabled ? length(var.network_association_subnet_names) : 0
  vpc_id = var.vpc_name != null ? data.aws_vpc.default[0].id : var.vpc_id
  filter {
    name   = "tag:Name"
    values = [var.network_association_subnet_names[count.index]]
  }
}

data "aws_subnet" "route" {
  for_each = { for r in var.routes : "${r.target_vpc_subnet_name}-${r.destination_cidr_block}" => r.target_vpc_subnet_name if r.target_vpc_subnet_name != null }
  filter {
    name   = "tag:Name"
    values = [each.value]
  }
}
