terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
  Name = "testing2"
  }
}

resource "aws_subnet" "main1" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Public_main_1"
  }
}
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public_main"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "b" {
 # for_each =  toset([aws_subnet.main.id,aws_subnet.main1.id])
  subnet_id      = aws_subnet.main1.id
  route_table_id = aws_route_table.example.id
}
resource "aws_route_table_association" "a" {
 # for_each =  toset([aws_subnet.main.id,aws_subnet.main1.id])
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.example.id
}

