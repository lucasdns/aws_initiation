provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "my_vpc" {
 cidr_block = "10.0.0.0/16"
 enable_dns_support = true
 enable_dns_hostnames = true

 tags = {
   Name = "MonVPC"
 }
}

resource "aws_subnet" "my_subnet" {
 vpc_id                  = aws_vpc.my_vpc.id
 cidr_block              = "10.0.1.0/24"
 map_public_ip_on_launch = true

 tags = {
   Name = "MonRéseau"
 }
}
