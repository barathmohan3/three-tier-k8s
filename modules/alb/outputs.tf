output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.alb_core.lb_dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.alb_core.lb_arn
}

output "alb_security_group_id" {
  description = "Security group ID attached to the ALB"
  value       = module.alb_core.security_group_id
}

output "http_listener_arns" {
  description = "ARNs of the ALB HTTP listeners"
  value       = module.alb_core.http_listener_arns
}

output "target_group_arns" {
  description = "ARNs of the target groups"
  value       = module.alb_core.target_group_arns
}
