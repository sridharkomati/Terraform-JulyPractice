output "vpc_id" {

  value       = try(aws_vpc.ntier.id)
}


output "vpc_cidr_block" {
  
  value       = try(var.ntier_vpc_info.vpc_cidr, "")
}

output "subnet_ids" {
  
  value       = compact(aws_subnet.subnets[*].cidr_block)
}
output "instance-id" {
  description = "The EC2 instance ID"
  value       = "${aws_instance.instance.id}"
}

output "instance-public-dns" {
  description = "The EC2 instance public DNS"
  value       = "${aws_instance.instance.public_dns}"
}

