resource "aws_key_pair" "ghes_kp" {
  key_name   = "${var.owner}-ghes-kp-tf"
  public_key = file("~/.ssh/id_rsa.pub")
}
