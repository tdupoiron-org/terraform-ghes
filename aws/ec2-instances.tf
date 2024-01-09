# Purpose: Search for GitHub Enterprise Server AMI that matches the version specified in the variables.tf file
data "aws_ami" "ghes_ami" {
  most_recent = true

  owners = ["895557238572"]

  filter {
    name   = "name"
    values = ["GitHub Enterprise Server ${var.ghes_version}"]
  }

}

# Purpose: Create an EC2 instance with the GitHub Enterprise Server AMI and a security group
resource "aws_instance" "ghes_ec2" {
  ami           = data.aws_ami.ghes_ami.id
  instance_type = var.aws_instance_type
  # key_name      = aws_key_pair.ghes_kp.key_name
  availability_zone           = var.aws_availability_zones[0]
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.ghes_subnets[0].id
  vpc_security_group_ids      = [aws_security_group.ghes_sg.id]

  root_block_device {
    volume_size = var.root_volume_size
    tags = {
      Name  = "${var.owner}-ghes-ebs-root-tf"
      Owner = var.owner
    }
    delete_on_termination = true
  }

  tags = {
    Name  = "${var.owner}-ghes-ec2-tf"
    Owner = var.owner
  }

}

resource "aws_ebs_volume" "ghes_ebs_data" {
  availability_zone = var.aws_availability_zones[0]
  size              = var.data_volume_size

  tags = {
    Name  = "${var.owner}-ghes-ebs-data-tf"
    Owner = var.owner
  }
}

resource "aws_volume_attachment" "ghes_ebs_attachment_data" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ghes_ebs_data.id
  instance_id = aws_instance.ghes_ec2.id
}