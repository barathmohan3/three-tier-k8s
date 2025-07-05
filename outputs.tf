output "alb_dns" {
  description = "DNS name of the ALB"
  value       = module.alb.lb_dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.alb.lb_arn
}

output "alb_security_group_id" {
  description = "Security group ID of the ALB"
  value       = module.alb.security_group_id
}

output "http_listener_arns" {
  description = "HTTP Listener ARNs"
  value       = module.alb.http_listener_arns
}

output "target_group_arns" {
  description = "Target group ARNs"
  value       = module.alb.target_group_arns
}
