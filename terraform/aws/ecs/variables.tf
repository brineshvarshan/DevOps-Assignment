variable "project_name" {
  description = "Project name prefix used for naming AWS resources"
  type        = string
  default     = "devops-assignment"
}

variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "ap-south-1"
}

# ------------------------------
# Networking Inputs
# ------------------------------
variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS services (Fargate runs inside these subnets)"
  type        = list(string)
}

variable "ecs_sg_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

# ------------------------------
# ECR Image Inputs
# ------------------------------
variable "backend_ecr_url" {
  description = "Backend ECR repo URL (without tag)"
  type        = string
}

variable "frontend_ecr_url" {
  description = "Frontend ECR repo URL (without tag)"
  type        = string
}

# ✅ Git SHA image tags (from CI/CD pipeline)
variable "backend_image_tag" {
  description = "Backend Docker image tag (Git SHA) pushed by CI pipeline"
  type        = string
}

variable "frontend_image_tag" {
  description = "Frontend Docker image tag (Git SHA) pushed by CI pipeline"
  type        = string
}

# ------------------------------
# ALB Target Group Inputs
# ------------------------------
variable "backend_tg_arn" {
  description = "ALB Target Group ARN for Backend (port 8000)"
  type        = string
}

variable "frontend_tg_arn" {
  description = "ALB Target Group ARN for Frontend (port 3000)"
  type        = string
}
