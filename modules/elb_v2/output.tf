output "security_group_id" {
  description = "Security group id of ALB"
  value       = aws_security_group.default.id
}

output "target_group_id" {
  description = "Target group id of ALB"
  value       = aws_lb_target_group.default.id
}


output "dns_name" {
  description = "DNS name of ALB"
  value       = aws_lb.default.dns_name
}
