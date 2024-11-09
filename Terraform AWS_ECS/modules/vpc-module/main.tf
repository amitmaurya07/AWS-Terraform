resource "aws_vpc" "three-tier" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "three-tier"
  }
}

data "aws_availability_zones" "available" {
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.three-tier.id
  cidr_block = cidrsubnet(aws_vpc.three-tier.cidr_block, 8, count.index + 1)
  count = 2
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "three-tier-public"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.three-tier.id
  cidr_block = cidrsubnet(aws_vpc.three-tier.cidr_block, 8, count.index + 4)
  count = 2

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
  count = length(aws_subnet.public)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private-rt-association" {
  count = length(aws_subnet.private)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private-rt.id
}