resource "aws_vpc" "ghes_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.owner}-ghes-vpc-tf"
    Owner = var.owner
  }
}

resource "aws_subnet" "ghes_subnet" {
  vpc_id     = aws_vpc.ghes_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.aws_availability_zone
  tags = {
    Name = "${var.owner}-ghes-subnet-tf"
    Owner = var.owner
  }
}

resource "aws_internet_gateway" "ghes_igw" {
  vpc_id = aws_vpc.ghes_vpc.id
  
  tags = {
    Name = "${var.owner}-ghes-igw-tf"
    Owner = var.owner
  }
}

resource "aws_route_table" "ghes_rtb" {
  vpc_id = aws_vpc.ghes_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ghes_igw.id
  }

  tags = {
    Name = "${var.owner}-ghes-rtb-tf"
    Owner = var.owner
  }
}

resource "aws_route_table_association" "ghes_route_table_association" {
  subnet_id      = aws_subnet.ghes_subnet.id
  route_table_id = aws_route_table.ghes_rtb.id
}