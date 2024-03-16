variable "AWS_ACCESS_KEY" {
  default = ""
}
variable "AWS_SECRET_KEY" {
  default = ""
}
variable "region" {
  default = "ap-south-1"
}

variable "environment" {
  description = "Deployment Environment"
  default     =  "prod"
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
variable "cluster_name" {
    description = "cluster name"
    default     = "Netflix-cluster"
}

variable "ami" {
  description = "This is ami id"
  default     = "ami-0014ce3e52359afbd"

}
variable "key_name" {
  description = "The name of the AWS key pair"
  default     = "tf-key"
}


variable "ecr_name" {
    description = "The name of the repository"
    type        = string
    default = "netflix-ecr"
  
}
variable "project" {
    description = "Project Environment"
    default     = "Netflix"
  
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
