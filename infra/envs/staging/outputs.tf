output "alb_dns_name" {
  description = "The DNS name of the production load balancer"
  value       = module.alb.alb_dns_name
}

output "repository_url" {
  description = "The URL of the production ECR repository"
  value       = module.ecr.repository_url
}




