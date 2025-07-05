output "alb_dns" {
  description = "DNS name of the ALB"
  value       = module.alb.lb.dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.alb.lb.arn
}

output "alb_security_group_id" {
  description = "ALB security group ID"
  value       = module.alb.security_group.id
}

output "http_listener_arns" {
  description = "HTTP Listener ARNs"
  value       = module.alb.listeners["http"].arn
}

output "target_group_arns" {
  description = "Target Group ARNs"
  value       = [
    module.alb.target_groups["frontend"].arn,
    module.alb.target_groups["backend"].arn
  ]
}
