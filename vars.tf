variable "AWS_ACCESS_KEY" {
  default = "AKIA6ODUZHDR2FDGMMF4"
}
variable "AWS_SECRET_KEY" {
  default = "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"
}
variable "region" {
  default = "us-east-2"
}

variable "environment" {
  description = "Deployment Environment"
}

variable "cidr_block" {
  description = "CIDR block of the vpc"
  default     = "20.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = ["20.0.1.0/24", "20.0.2.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
  default     = ["20.0.10.0/24"]
}

variable "instance_type" {
  description = "This is a instance type"
  default = "t2.micro"
  

}

variable "ami" {
  description = "This is ami id"
  default     = "ami-05fb0b8c1424f266b"

}
variable "key_name" {
  description = "The name of the AWS key pair"
  default     = "tf-key"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default = "zomato-adrak-lasan"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "zomato-terraform-lock"
}

variable "dynamodb_hash_key" {
  description = "The hash key of the DynamoDB table"
  type        = string
  default     = "LockId"
}

variable "dynamodb_billing_mode" {
  description = "The billing mode for the DynamoDB table"
  type        = string
  default     = "PAY_PER_REQUEST"
}
variable "ecr_name" {
    description = "The name of the repository"
    type        = string
    default = "zomato-ecr"
  
}
variable "project" {
    description = "Project Environment"
  
}
variable "tags" {
    description = "The key-value maps for tagging"
    type = map(string)
    default = {}
}

variable "image_mutability" {
    description = "Provide image mutability"
    type = string
    default = "MUTABLE"
  
}

variable "encryption_type" {
    description = "Provide type of encryption here"
    type = string
    default = "KMS"
  
}
