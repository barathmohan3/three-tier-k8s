output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.alb_core.load_balancer_dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.alb_core.load_balancer_arn
}

output "alb_security_group_id" {
  description = "Security group ID attached to the ALB"
  value       = module.alb_core.security_group_id
}

output "listener_arns" {
  description = "ARNs of all listeners"
  value       = module.alb_core.listener_arns
}

output "target_group_arns" {
  description = "ARNs of all target groups"
  value       = module.alb_core.target_group_arns
}
