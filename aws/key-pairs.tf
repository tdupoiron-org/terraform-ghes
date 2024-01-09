# resource "aws_key_pair" "ghes_kp" {
#   key_name   = "${var.owner}-ghes-kp-tf"
#   public_key = file("~/.ssh/id_rsa.pub")
#   tags = {
#     Name  = "${var.owner}-ghes-kp-tf"
#     Owner = var.owner
#   }
# }
