variable "name" {
  description = "Name of the instance"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "app_port_range_min" {
  description = "Start range port for application"
  type        = number
}

variable "app_port_range_max" {
  description = "End range port for application"
  type        = number
}

variable "load_balancer_security_group_id" {
  description = "Security group id for load balancer"
  type        = string
}
