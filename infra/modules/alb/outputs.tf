output "alb_security_group_id" {
  value = aws_security_group.alb.id
}

output "target_group_arn" {
  value = aws_lb_target_group.app.arn
}

output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "target_group_name" {
  value = aws_lb_target_group.app.name
}

output "green_target_group_name" {
  value = aws_lb_target_group.green.name
}

output "prod_listener_arn" {
  value = aws_lb_listener.http.arn
}

output "test_listener_arn" {
  value = aws_lb_listener.test.arn
}

output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.main.arn
}
