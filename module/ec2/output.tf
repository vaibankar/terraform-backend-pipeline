output "instance_id" {
  value = aws_instance.Netflix.id
}

output "instance_public_ip" {
  value = aws_instance.Netflix.public_ip
}

output "instance_private_ip" {
  value = aws_instance.Netflix.private_ip
}

output "public_key" {
  value = aws_key_pair.tf-key.public_key
}

