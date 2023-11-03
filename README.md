# terraform-ghes

Spin up a GitHub Enterprise Server (GHES) instance in AWS using Terraform.

## Usage

* Create a `terraform.tfvars` file with the following variables:

```hcl
owner = "myorg"
aws_region = "us-east-1"
aws_availability_zone = "us-east-1a"
aws_instance_type = "m5.xlarge"
key_pair_name = "mykey"
ghes_version = "3.0.0"
data_volume_size = 100
```

* Run Terraform:

```hcl
cd aws
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
terraform init
terraform apply -auto-approve
```

* Get the public IP address of the instance:

```hcl
terraform output ghes_public_ip
```