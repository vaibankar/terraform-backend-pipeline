variable "environment" {
    description = "Deployment Environment"
  
}
variable "project" {
    description = "Project Environment"
  
}
variable "ecr_name" {
    description = "The name of the ecr registory"
    type = string
    default = " "
  
}
variable "image_tag_mutability" {
    description = "provide image mutability"
    type = string
    default = " "
  
}
variable "encryption_type" {
    description = "provide type to encryption here"
    type = string
    default = "KMS"
  
}
variable "tags" {
    description = "The key-value maps for tagging"
    type = map(string)
    
  
}

