variable "owner" {
  description = "The owner of the infrastructure"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "aws_availability_zone" {
  description = "The availability zone to deploy resources in"
  type        = string
}

variable "aws_instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
  default     = "m5.4xlarge"
}

variable "key_pair_name" {
  description = "The name of the key pair to use for the EC2 instance"
  type        = string
}

variable "ghes_version" {
  description = "The version of GitHub Enterprise Server to deploy"
  type        = string
}

variable "root_volume_size" {
  description = "The size of the root volume in GB"
  type        = number
}

variable "data_volume_size" {
  description = "The size of the data volume in GB"
  type        = number
}



