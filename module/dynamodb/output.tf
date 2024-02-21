output "table_name" {
  value = aws_dynamodb_table.terraform_lock.name
}

output "hash_key" {
  value = aws_dynamodb_table.terraform_lock.hash_key
}

output "billing_mode" {
  value = aws_dynamodb_table.terraform_lock.billing_mode
}

