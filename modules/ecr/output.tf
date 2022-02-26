output "repo_url" {
  description = "URL of repository"
  value       = aws_ecr_repository.repo.repository_url
}
