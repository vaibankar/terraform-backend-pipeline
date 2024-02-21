output "ecr_repository_url" {
  value = aws_ecr_repository.ecr.repository_url
}

output "ecr_repository_name" {
  value = aws_ecr_repository.ecr.name
}

output "ecr_repository_encryption_type" {
  value = aws_ecr_repository.ecr.encryption_configuration.0.encryption_type
}

output "ecr_repository_scan_on_push" {
  value = aws_ecr_repository.ecr.image_scanning_configuration.0.scan_on_push
}

output "ecr_repository_tags" {
  value = aws_ecr_repository.ecr.tags
}

