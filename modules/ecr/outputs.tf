# Output all repository URLs
output "ecr_repository_urls" {
  description = "Map of ECR repository URLs"
  value = {
    for repo in local.repositories :
    repo => aws_ecr_repository.repositories[repo].repository_url
  }
}

# Output all repository ARNs
output "ecr_repository_arns" {
  description = "Map of ECR repository ARNs"
  value = {
    for repo in local.repositories :
    repo => aws_ecr_repository.repositories[repo].arn
  }
}

# Output all repository names
output "ecr_repository_names" {
  description = "Map of ECR repository names"
  value = {
    for repo in local.repositories :
    repo => aws_ecr_repository.repositories[repo].name
  }
}

# Individual service repository URLs for easy access
output "cede_integration_service_url" {
  description = "ECR URL for cede-integration-service"
  value       = aws_ecr_repository.repositories["cede-integration-service"].repository_url
}

output "cede_ui_url" {
  description = "ECR URL for cede-ui"
  value       = aws_ecr_repository.repositories["cede-ui"].repository_url
}

