variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "project_name" {
  type    = string
  default = "devops-assignment"
}

variable "alert_email" {
  type        = string
  description = "Email address to receive alerts"
}
