variable "cidr_block" {
  description = "CIDR block for the VPC"
}

variable "environment" {
  description = "Environment name"
}

variable "public_subnets_cidr" {
  description = "CIDR block for the public subnet"
}

variable "private_subnets_cidr" {
  description = "CIDR block for the private subnet"
}

variable "availability_zones" {
  description = "Availability Zone for the subnets"
  default     = ["us-east-2a","us-east-2b","us-east-2c"]
}
variable "region" {
  default = "us-east-2"
}

