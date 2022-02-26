variable "name" {
  description = "Name of the ELB"
  type        = string
}

variable "subnets_id" {
  description = " A list of subnet IDs to attach to the ELB."
  type        = list(any)
}


variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "healthy_threshold" {
  description = "The number of checks before the instance is declared healthy"
  type        = number
  default     = 2
}
variable "unhealthy_threshold" {
  description = "The number of checks before the instance is declared unhealthy"
  type        = number
  default     = 2
}

variable "health_check_target" {
  description = "The target of the health check"
  type        = string
}

variable "listener_instance_port" {
  description = "The port on the instance to route to"
  type        = number
}
