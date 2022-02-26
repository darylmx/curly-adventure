variable "name" {
  description = "Name of the ASG"
  type        = string
}

variable "instance_type" {
  description = "compute instance type to be used for ASG"
  type        = string
}

variable "security_group_id" {
  description = "A list of associated security group IDS."
  default     = null
}

variable "image_id" {
  type = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_zone_identifier" {
  description = "VPC zone identifier"
}

variable "min_size" {
  description = "The minimum size of the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum size of the Auto Scaling Group"
  type        = number
  default     = 4
}

variable "min_elb_capacity" {
  description = "to wait for this number of instances from ASG to show up healthy in the ELB only on creation"
  type        = number
  default     = 1
}

variable "load_balancer_name" {
  description = "name of Load Balancer that is connecting to ASG"
  type        = string
}

variable "template_file_path" {
  description = "full file path for template that is to be used by instance in launchconfig"
  type        = string
  default     = null
}
variable "template_file_data" {
  description = "data object for template that is to be used by instance in launchconfig"
  default     = null
}


