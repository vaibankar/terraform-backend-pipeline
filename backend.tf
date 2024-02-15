#create s3 bucket

resource "aws_s3_bucket" "mybucket" {
    bucket = "zomato_bucket"
    versioning {
      enabled = true
    }
    server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
      }
    }
  
}


#create dynamodb table

resource "aws_dynamodb_table" "statelock" {
  name             = "state-lock"
  hash_key         = "LockId"
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "LockId"
    type = "S"
  }
}
