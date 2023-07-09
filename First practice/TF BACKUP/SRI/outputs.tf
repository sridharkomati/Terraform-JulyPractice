output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.ntier.id)
}


output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = try(var.ntier_vpc_info.vpc_cidr, "")
}

output "subnet_ids" {
  description = "List of cidr_blocks of private subnets"
  value       = compact(aws_subnet.subnets[*].cidr_block)
}

