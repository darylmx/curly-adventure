variable "name" {
  description = "Name of the ECS"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets_id" {
  description = "Subnet id of networks to be used"
  type        = any
}

variable "app_count" {
  description = "Counts of application to be deployed"
  type        = number
}

variable "app_name" {
  description = "Nmae of application to be deployed"
  type        = string
}
variable "app_port" {
  description = "Port of application to be deployed"
  type        = number
}

variable "load_balancer_security_group_id" {
  description = "Security group id of Load Balancer for use iwth ECS"
  type        = string
}
variable "load_balancer_target_group_id" {
  description = "Target group id of Load Balancer for use with ECS"
  type        = string
}

variable "task_definition_cpu" {
  description = "Number of cpu units used by the task"
  type        = number
}

variable "task_definition_memory" {
  description = "Amount (in MiB) of memory used by the task"
  type        = number
}

variable "template_file_path" {
  description = "File path for template that is to be used by instance in launchconfig"
  type        = string
}

variable "template_file_data" {
  description = "Data object for template that is to be used by instance in launchconfig"
  type        = map(string)
}

