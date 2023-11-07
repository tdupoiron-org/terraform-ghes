variable "s3_bucket_name" {
  description = "The name of the S3 bucket to use for the backend"
  type        = string
}

variable "s3_key_prefix" {
  description = "The prefix to use for the S3 key"
  type        = string
}

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

variable "ghes_admin_password" {
  description = "The password for the GitHub Enterprise Server admin user"
  type        = string
}