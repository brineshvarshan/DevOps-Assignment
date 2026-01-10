output "backend_ecr_url" {
  value       = aws_ecr_repository.backend.repository_url
  description = "Backend ECR repository URL"
}

output "frontend_ecr_url" {
  value       = aws_ecr_repository.frontend.repository_url
  description = "Frontend ECR repository URL"
}
