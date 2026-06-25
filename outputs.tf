# ACM Certificate Outputs
output "acm_certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = module.acm.acm_certificate_arn
}

output "acm_certificate_status" {
  description = "Status of the ACM certificate (will be PENDING_VALIDATION until DNS records are added)"
  value       = module.acm.acm_certificate_status
}

output "acm_validation_records" {
  description = "DNS validation records to be added to your external DNS provider"
  value       = module.acm.validation_records
}

# Instructions for DNS validation
output "dns_validation_instructions" {
  description = "Instructions for adding DNS validation records"
  value       = <<-EOT
  
  ========================================
  ACM CERTIFICATE DNS VALIDATION REQUIRED
  ========================================
  
  Your ACM certificate has been created but requires DNS validation.
  Please add the following CNAME records to your DNS provider:
  
  Run: terraform output acm_validation_records
  
  Then create CNAME records in your DNS provider with the record_name and record_value from the output.
  
  The certificate will be validated automatically once AWS detects the DNS records (5-30 minutes after DNS propagation).
  
  EOT
}

# Ingress ALB Security Group Outputs
output "ingress_alb_sg_id" {
  description = "Security group ID to attach to the Kubernetes Ingress ALB via annotation: alb.ingress.kubernetes.io/security-groups"
  value       = module.security_groups.ingress_alb_sg_id
}

output "ingress_alb_sg_arn" {
  description = "ARN of the Ingress ALB security group"
  value       = module.security_groups.ingress_alb_sg_arn
}

output "qacededevelopereks_console_password" {
  description = "Initial console password for qacededevelopereks IAM user"
  value       = module.iam.qacededevelopereks_console_password
  sensitive   = true
}

output "qacededevelopereks_access_key_id" {
  description = "Access key ID for qacededevelopereks IAM user"
  value       = module.iam.qacededevelopereks_access_key_id
}

output "qacededevelopereks_secret_access_key" {
  description = "Secret access key for qacededevelopereks IAM user"
  value       = module.iam.qacededevelopereks_secret_access_key
  sensitive   = true
}