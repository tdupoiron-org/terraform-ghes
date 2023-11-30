#Install Terraform on Alpine
sudo apk add --update --no-cache terraform

# Install Azure CLI on Alpine
sudo apk add py3-pip
sudo apk add gcc musl-dev python3-dev libffi-dev openssl-dev cargo make
pip install --upgrade pip
pip install azure-cli

# Install npm on Alpine
sudo apk add nodejs npm