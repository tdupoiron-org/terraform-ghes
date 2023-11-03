resource "aws_ebs_volume" "ghes_data_ebs" {
  availability_zone = var.aws_availability_zone
  size              = var.data_volume_size

  tags = {
    Name = "${var.owner}-ghes-data"
  }
}