resource "aws_security_group" "ofl-allow-ssh-connection" {
  vpc_id = aws_vpc.ofl-ecom-dev-vpc.id
  name   = title("${var.prj_sn}-${terraform.workspace}-allow-ssh-connection")
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "ofl-webserver-connection" {
  vpc_id = aws_vpc.ofl-ecom-dev-vpc.id
  name   = title("${var.prj_sn}-${terraform.workspace}-Web-Sg")

  dynamic "ingress" {
    for_each = var.inbound-port-numbers
    content {
      protocol    = "tcp"
      from_port   = ingress.value
      to_port     = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH"
    }
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

