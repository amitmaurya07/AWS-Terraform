resource "aws_vpc" "three-tier" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "three-tier"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.three-tier.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "three-tier-public"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.three-tier.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "three-tier-private"
  }
}

resource "aws_internet_gateway" "three-tier-igw" {
  vpc_id = aws_vpc.three-tier.id
  tags = {
    "Name" = "three-tier-igw"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.three-tier.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.three-tier-igw.id
  }
  tags = {
    "Name" = "three-tier-public-rt"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.three-tier.id
  tags = {
    "Name" = "three-tier-private-rt"
  }
}

resource "aws_route_table_association" "public-rt-association" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private-rt-association" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private-rt.id
}