resource "aws_vpc" "micro_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "Microservices VPC",
    project     = "andres.castrillonv-rampup",
    responsible = "andres.castrillonv"}
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.micro_vpc.id

  tags = {
    Name = "Microservices internet gateway",
    project     = "andres.castrillonv-rampup",
    responsible = "andres.castrillonv"}
}

resource "aws_subnet" "microsubnet_private" {
  vpc_id     = aws_vpc.micro_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "private"
    project = "andres.castrillonv-rampup"
    responsible = "andres.castrillonv" }
}

resource "aws_subnet" "microsubnet_public" {
  vpc_id     = aws_vpc.micro_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public"
    project = "andres.castrillonv-rampup"
    responsible = "andres.castrillonv" }
}

resource "aws_subnet" "microsubnet_public2" {
  vpc_id     = aws_vpc.micro_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public2"
    project = "andres.castrillonv-rampup"
    responsible = "andres.castrillonv" }
}


resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.micro_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public-rta" {
  subnet_id      = aws_subnet.microsubnet_public.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public2-rta" {
  subnet_id      = aws_subnet.microsubnet_public2.id
  route_table_id = aws_route_table.public-rt.id
}


resource "aws_eip" "elasticip" {
  vpc = true
}

resource "aws_network_interface" "test" {
  subnet_id       = aws_subnet.microsubnet_public.id

  attachment {
    instance     = aws_instance.microserviceFront.id
    device_index = 1
  }
}

resource "aws_nat_gateway" "microservices-nat" {
  allocation_id = aws_eip.elasticip.id
  subnet_id     = aws_subnet.microsubnet_public.id
  depends_on    = [aws_internet_gateway.gw]
}


resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.micro_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.microservices-nat.id
  }
}

resource "aws_route_table_association" "private-rta" {
  subnet_id      = aws_subnet.microsubnet_private.id
  route_table_id = aws_route_table.private-rt.id
}



