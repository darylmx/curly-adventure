output "vpc_id" {
  description = "id of VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnets_id" {
  description = "id of public subnets"
  value       = ["${aws_subnet.public_subnet.*.id}"]
}

output "private_subnets_id" {
  description = "id of private subnets"
  value       = ["${aws_subnet.private_subnet.*.id}"]
}

output "db_subnets_id" {
  description = "id of db subnets"
  value       = ["${aws_subnet.db_subnet.*.id}"]
}

output "public_route_table" {
  description = "id of public route table"
  value       = aws_route_table.public.id
}
