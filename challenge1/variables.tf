variable "db_name" {
  type    = string
  default = "testdb"
}

variable "db_password" {
  type      = string
  sensitive = true
  default   = "asdfghjkl"
}
variable "db_username" {
  type      = string
  sensitive = true
  default   = "root"
}

variable "project_name" {
  description = "Name of the project."
  type        = string
  default     = "q1"
}

variable "environment" {
  description = "The Deployment environment"
  default     = "test"
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default     = {}
}
