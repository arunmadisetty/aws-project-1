resource "aws_vpc" "terraform" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraform.id

  tags = {
    Name = "TerraformIGW"
  }
}

resource "aws_subnet" "terraform" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "terraform"
  }
}

resource "aws_subnet" "terraform1" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.20.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform1"
  }
}

resource "aws_subnet" "terraform2" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.30.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform2"
  }
}

resource "aws_subnet" "private_sub" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.40.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "PrivateSubnet"
  }
}

resource "aws_subnet" "private_sub2" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.50.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "PrivateSubnet2"
  }
}

resource "aws_subnet" "private_sub3" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "10.0.60.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "PrivateSubnet3"
  }
}



resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  
  tags = {
    Name = "TerraformPublicRT"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.terraform.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.terraform1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.terraform2.id
  route_table_id = aws_route_table.public_rt.id
}

# resource "aws_route_table_association" "i" {
#   gateway_id     = aws_internet_gateway.gw.id
#   route_table_id = aws_route_table.public_rt.id
# }

