provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0aafdae616ee7c9b7"
  instance_type = "t2.micro"
}

