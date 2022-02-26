resource "aws_ecr_repository" "repo" {
  #name = "myapp"
  name = var.name
}
