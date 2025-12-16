output "cede_rds_endpoint" {
  value = aws_db_instance.cede_db_instance.endpoint
}

output "cede_rds_writer_endpoint" {
  value = aws_db_instance.cede_db_instance.endpoint
}

output "cede_rds_username" {
  value = aws_db_instance.cede_db_instance.username
}

output "cede_rds_password" {
  value     = aws_db_instance.cede_db_instance.password
  sensitive = true
}

output "cede_rds_sg_id" {
  value       = aws_security_group.cede_rds_sg.id
  description = "Security group ID for the CEDE RDS instance"
}