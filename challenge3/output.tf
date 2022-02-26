output "myapp-repository-URL" {
  description = "URL of container repository. Upload docker images to this location"
  value       = module.ecr.repo_url
}

output "test_endpoint" {
  description = "URL of endpoint to check"
  value       = "${module.lb.dns_name}/api/ping"
}
