output "security_group_id" {
  description = "Security group id of instance"
  value       = aws_security_group.main.id
}
