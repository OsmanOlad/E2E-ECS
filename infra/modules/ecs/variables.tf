variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "alb_security_group_id" {
  type = string
}

variable "dynamodb_table_arn" {
  type = string
}


variable "target_group_name" {
  description = "Name of the blue target group"
  type        = string
}

variable "green_target_group_name" {
  description = "Name of the green target group"
  type        = string
}

variable "prod_listener_arn" {
  description = "ARN of the production ALB listener"
  type        = string
}

variable "test_listener_arn" {
  description = "ARN of the test ALB listener"
  type        = string
}
