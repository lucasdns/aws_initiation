provider "aws" {
  region = "us-west-1"
}

resource "aws_key_pair" "my_key_pair" {
 key_name   = "lucas_key"
 public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "my_security_group" {
 name        = "lucas_group"
 description = "Allow incoming HTTP traffic"

 ingress {
   from_port = 80
   to_port   = 80
   protocol  = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "my_instance" {
 ami           = "ami-0aafdae616ee7c9b7"
 instance_type = "t2.micro"
 key_name      = aws_key_pair.my_key_pair.key_name
 vpc_security_group_ids = [aws_security_group.my_security_group.id]

 user_data = <<-EOF
             #!/bin/bash
             apt update
             apt install -y apache2
             echo "Hello Terraform" > /var/www/html/index.html
             systemctl start apache2
             systemctl enable apache2
             EOF

 tags = {
   Name = "MyEC2Instance"
 }
}
