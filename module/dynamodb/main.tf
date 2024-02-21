resource "aws_dynamodb_table" "terraform_lock" {
  name             = var.dynamodb_table_name
  hash_key         = var.dynamodb_hash_key
  billing_mode     = var.dynamodb_billing_mode

  attribute {
    name = "LockId"
    type = "S"
  }
}
