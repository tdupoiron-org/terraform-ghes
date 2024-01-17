terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    ovh = {
      source = "ovh/ovh"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}

provider "ovh" {
  endpoint = "ovh-eu"
}