variable "name" {
  description = "Name of the database"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in gibibytes"
  type        = number
}

variable "instance_class" {
  description = "Instance class for db"
  type        = string
}

variable "db_subnets_id" {
  description = "Subnets id for db"
  type        = list(any)
}

variable "web_subnets_cidr" {
  description = "Subnets cidr for web"
  type        = list(any)
}


variable "db_name" {
  description = "Name of initial db to be created"
  type        = string
}

variable "db_user" {
  description = "Username for the master DB user"
  type        = string
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
}
