variable "db_name" {
  description = "Name of database to be created for webapp usage"
  type        = string
  default     = "testdb"
}
variable "db_password" {
  description = "Password of database user for webapp access"
  type        = string
  sensitive   = true
  default     = "asdfghjkl"
}
variable "db_username" {
  description = "Username of database user for webapp access"
  type        = string
  sensitive   = true
  default     = "root"
}
