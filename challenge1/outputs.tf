output "url_to_connect" {
  description = "DNS name of ELB endpoint"
  value       = module.lb.dns_name
}
