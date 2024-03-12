# terraform-ghes

Spin up a GitHub Enterprise Server (GHES) instance in AWS using Terraform.

## Architecture

```mermaid
flowchart LR
vpc(ghes_vpc)
subnet(ghes_subnet)
internet_gateway(ghes_igw)
route_table(ghes_route_table)
security_group(ghes_sg)
instance(ghes_ec2)
volume_data(ghes_data_ebs)
volume_root(ghes_root_ebs)
alb(ghes_lb)
alb_listener(ghes_lb_listener)
alb_target_group(ghes_lb_target_group)
acm(ghes_acm)
ovh_dns(ovh_dns)

subgraph "AWS vpc"
vpc-->subnet
vpc-->route_table
vpc-->internet_gateway
vpc-->security_group
route_table-->internet_gateway
route_table-->subnet
end

subgraph "ec2-instances"
instance-->subnet
instance-->security_group
instance-->volume_root
instance-->volume_data
end

subgraph "load-balancer"
alb-->vpc
alb-->subnet
alb-->security_group
alb-->alb_listener

alb_listener-->acm
alb_listener-->alb_target_group

alb_target_group-->instance
end

ovh_dns-->acm
ovh_dns-->alb

```

## Usage

* Create a `terraform.tfvars` file with the following variables:

```hcl
owner                 = "tdupoiron"
aws_region            = "eu-west-3"
aws_availability_zones = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
aws_instance_type     = "m5.8xlarge"
ghes_version          = "3.10.3"
root_volume_size      = 200
data_volume_size      = 200

ovh_domain_name       = "dupoiron.com"
ghes_domain_name      = "ghes.dupoiron.com"
```

Available GHES versions can be found [here](https://enterprise.github.com/releases)

Technical prerequisites can be found [here](https://docs.github.com/en/enterprise-server@3.10/admin/installation/setting-up-a-github-enterprise-server-instance/installing-github-enterprise-server-on-vmware#minimum-requirements)

* Run Terraform:

```hcl
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"

export OVH_CONSUMER_KEY="a consumer key"
export OVH_APPLICATION_KEY="an application key"
export OVH_APPLICATION_SECRET="an application secret"
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1

cd aws
terraform init -backend-config=backend.conf
terraform plan;terraform apply -auto-approve
```

* Read public ip and useful information from the output:

```hcl
ghes_homepage = "https://35.180.134.22"
ghes_setup_endpoint = "https://35.180.134.22:8443/setup"
ghes_ssh_command = "ssh -i ~/.ssh/mykeypair.pem -p 122 admin@35.180.134.22"
```

* Destroy the infrastructure:

```hcl
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1

cd aws
terraform init -backend-config=backend.conf
terraform destroy -auto-approve
```

## Connect to the instance

* Download the private key from GitHub Actions artifacts

or

* Add your public key to the instance using the management console

* Connect to the instance using the ssh command from the output

```shell
ssh -p 122 admin@ghes.domain.com -i $HOME/.ssh/public_key
```

## Configure Let's Encrypt certificate

* Enable ACME protocol on the instance and issue a certificate

```shell
ghe-ssl-acme -e
```
