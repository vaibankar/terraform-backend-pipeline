variable "cluster_name" {
    description = "cluster name"
}
variable "subnet_ids" {
    description = "subnet ids"
    # type = string
}
variable "desired_capacity" {
    description = "desired capacity"
}
variable "min_size" {
    description = "minimum size"
}
variable "max_size" {
    description = "max size"
}
variable "default_security_group_ids" {
  description = "IDs of the default security groups in the VPC"
  type = any
}
variable "instance_type" {
  description = "this is a instance type"
  type = string
 

}
