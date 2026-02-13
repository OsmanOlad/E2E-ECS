variable "project_name" {
  description = "The name of the project for this environment"
  type        = string
}


variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}
