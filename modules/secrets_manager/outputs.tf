output "postgres_secret_arn" {
  description = "ARN of the PostgreSQL RDS credentials secret"
  value       = aws_secretsmanager_secret.postgres_rds_credentials.arn
}

output "postgres_secret_name" {
  description = "Name of the PostgreSQL RDS credentials secret"
  value       = aws_secretsmanager_secret.postgres_rds_credentials.name
}

