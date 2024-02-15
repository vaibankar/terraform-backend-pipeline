variable "region" {
  description = "The AWS region to deploy resources"
  default     = " "
}

variable "access_key" {
  description = "The AWS access key"
  default     = " "

}

variable "secret_key" {
  description = "The AWS secret key"
  default     = " "
}

variable "instance_type" {
  description = "this is a instance type"
  default     = " "

}

variable "ami" {
  description = "this is ami id"
  default     = " "

}
variable "key_name" {
  description = "The name of the AWS key pair"
  default     = " "
}
variable "subnet_id" {
  description = "ID of the public subnet where EC2 will be launched"
  type = any
}


variable "default_security_group_ids" {
  description = "IDs of the default security groups in the VPC"
}

