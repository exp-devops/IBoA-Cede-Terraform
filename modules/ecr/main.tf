# ECR Repositories for all services

locals {
  repositories = [
    "cede-integration-service",
    "cede-ui"
  ]
}

resource "aws_ecr_repository" "repositories" {
  for_each = toset(local.repositories)

  name                 = "${var.project_name}-${var.project_segment}-${var.project_env}-${each.value}"
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.project_segment}-${var.project_env}-${each.value}"
      Service     = each.value
      Environment = var.project_env
    }
  )
}

# Lifecycle policy to manage image retention
resource "aws_ecr_lifecycle_policy" "repositories_policy" {
  for_each   = toset(local.repositories)
  repository = aws_ecr_repository.repositories[each.key].name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 30 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
