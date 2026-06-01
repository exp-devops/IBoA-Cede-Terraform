# Create secret for PostgreSQL RDS
resource "aws_secretsmanager_secret" "postgres_rds_credentials" {
  name        = "${var.project_name}-${var.project_segment}-${var.project_env}-RDSCredentials"
  description = "PostgreSQL RDS credentials for ${var.project_name}-${var.project_env}"
  kms_key_id  = var.kms_key_id

  tags = merge(
    var.tags,
    {
      Name     = "${var.project_name}-${var.project_segment}-${var.project_env}-RDSCredentials"
      Database = "PostgreSQL"
    }
  )
}
# Store PostgreSQL credentials
resource "aws_secretsmanager_secret_version" "postgres_rds_credentials" {
  secret_id = aws_secretsmanager_secret.postgres_rds_credentials.id
  secret_string = jsonencode({
    username = var.cede_rds_username
    password = var.cede_rds_password
    #master_password = var.cede_rds_master_password
    engine = "postgres"
    port   = var.rdsProperty["PORT"]
  })
}
# Create a resource policy for PostgreSQL credentials
resource "aws_secretsmanager_secret_policy" "postgres_rds_credentials" {
  secret_arn = aws_secretsmanager_secret.postgres_rds_credentials.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EnablePostgresRDSAccess"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:PrincipalAccount" = data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}

# Get current AWS account ID
data "aws_caller_identity" "current" {}

# Create secret for Application Configuration
resource "aws_secretsmanager_secret" "iboa_app_config" {
  name        = "IBoASecretManager"
  description = "Application configuration for IBoA"
  kms_key_id  = var.kms_key_id

  tags = merge(
    var.tags,
    {
      Name        = "IBoASecretManager"
      Type        = "ApplicationConfig"
      Environment = var.project_env
    }
  )
}
