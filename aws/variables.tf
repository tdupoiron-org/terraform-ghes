variable "owner" {
  description = "The owner of the infrastructure"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "aws_availability_zones" {
  description = "The availability zones to deploy resources in"
  type        = list(string)
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

variable "ovh_domain" {
  description = "The domain name to use for the AWS resources"
  type        = string
}

variable "ghes_subdomain" {
  description = "The domain name to use for the GitHub Enterprise Server instance"
  type        = string
}

variable "ghes_admin_password" {
  description = "The password for the GitHub Enterprise Server admin user"
  type        = string
}