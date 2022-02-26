output "security_group_id" {
  description = "Security group id of ELB"
  value       = aws_security_group.main.id
}

output "dns_name" {
  description = "DNS name of ELB"
  value       = aws_elb.main.dns_name
}

output "name" {
  description = "Name of ELB"
  value       = aws_elb.main.name
}
