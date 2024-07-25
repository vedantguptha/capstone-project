##################################################################
##                   SSH Key Generation                         ##
##################################################################
resource "tls_private_key" "ofl-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

##################################################################
##                  AWS Key Pair Creation                       ##
##################################################################
resource "aws_key_pair" "ofl-key-pair" {
  key_name   = title("${var.prj_sn}-${terraform.workspace}-ssh-key")
  public_key = tls_private_key.ofl-key.public_key_openssh
}

##################################################################
##                   .Pem file Creation                         ##
##################################################################
resource "local_file" "key_file" {
  filename = "${aws_key_pair.ofl-key-pair.key_name}.pem"
  content  = tls_private_key.ofl-key.private_key_openssh
}