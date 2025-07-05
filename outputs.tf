output "alb_dns" {
  description = "DNS name of the ALB"
  value       = module.alb.lb_dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.alb.lb_arn
}

output "http_listener_arns" {
  description = "HTTP Listener ARNs"
  value       = module.alb.http_listener_arns
}

output "target_group_arns" {
  description = "Target Group ARNs"
  value       = module.alb.target_group_arns
}
