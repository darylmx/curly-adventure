
variable "name" {
  description = "Name of the ALB"
  type        = string
}
variable "subnets_id" {
  description = "Subnet ids to be handled by ALB"
  type        = list(any)
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "health_check_port" {
  description = "Port to use to connect with the target"
  type        = number
}
variable "health_check_path" {
  description = "Destination for the health check request"
  type        = string
}
variable "health_check_protocol" {
  description = "Protocol to use to connect with the target"
  type        = string
  default     = "HTTP"
}
