variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "alb_arn" {
  description = "The ARN of the ALB linked to the WAF"
  type        = string
}
