locals {
  net_cidr = "10.17.0.0/24"
  public-subnet = [for k, v in data.aws_availability_zones.available.names : cidrsubnet(local.net_cidr, 2, k)]
}

##################################################################
##                       VPC Creation                           ##
##################################################################
resource "aws_vpc" "ofl-ecom-dev-vpc" {
  cidr_block           = local.net_cidr
  enable_dns_hostnames = true
  tags = {
    Name = title("${var.prj_sn}-${var.env}-vpc")
  }
}


##################################################################
##                   Public Subnet - 1                         ##
##################################################################

resource "aws_subnet" "ofl-ecom-public-subnets" {
  count = length(local.public-subnet)  
  vpc_id                  = aws_vpc.ofl-ecom-dev-vpc.id
  cidr_block              = local.public-subnet[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true     
  tags = {
    Name = title("${var.prj_sn}-${var.env}-Public-Subnet-${count.index+1}")
  }
  depends_on = [aws_vpc.ofl-ecom-dev-vpc]
}


##################################################################
##                       IGW Creation                           ##
##################################################################

resource "aws_internet_gateway" "ofl-ecom-igw" {
  vpc_id = aws_vpc.ofl-ecom-dev-vpc.id
  tags = {
    Name = title("${var.prj_sn}-${var.env}-IGW")
  }
}


##################################################################
##                       Public RT                              ##
##################################################################

resource "aws_route_table" "ofl-ecom-prt" {
  vpc_id = aws_vpc.ofl-ecom-dev-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ofl-ecom-igw.id
  }
  tags = {
   Name = title("${var.prj_sn}-${var.env}-PRT")
  }
}


resource "aws_route_table_association" "ecom-accoc-public-subnets" {
  count = length(local.public-subnet)
  subnet_id      = element(aws_subnet.ofl-ecom-public-subnets[*].id, count.index)
  route_table_id = aws_route_table.ofl-ecom-prt.id
}
