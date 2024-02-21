output "bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket
}

output "bucket_versioning_enabled" {
  value = aws_s3_bucket.s3_bucket.versioning[0].enabled
}

output "server_side_encryption_algorithm" {
  value = aws_s3_bucket.s3_bucket.server_side_encryption_configuration[0].rule[0].apply_server_side_encryption_by_default[0].sse_algorithm
}

