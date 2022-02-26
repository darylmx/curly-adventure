variable "name" {
  description = "Name of the network"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
  type        = string
}

variable "public_subnets_cidr" {
  description = "The CIDR block for the public subnet"
  type        = list(any)
}

variable "private_subnets_cidr" {
  description = "The CIDR block for the private subnet"
  type        = list(any)
}

variable "db_subnets_cidr" {
  description = "The CIDR block for the db subnet"
  type        = list(any)
  default     = []
}

variable "region" {
  description = "The region to setup network"
  type        = string
}

variable "availability_zones" {
  description = "The AZs that the resources will be launched"
  type        = list(any)
}
