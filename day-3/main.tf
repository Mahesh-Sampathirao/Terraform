#create VPC
resource "aws_vpc" "Name" {
cidr_block = "10.0.0.0/16"
tags={
    Name = "server"
}  
}
#create internet gateway and attach to vpc
resource "aws_internet_gateway" "Name" {
    vpc_id = var.vpc_id #IG attach block to vpc
  
}

#create subnet
resource "aws_subnet" "Name" {
    cidr_block = "10.0.0.0/24"
    vpc_id = var.vpc_id 
  
}


#cretae Route tables & attach internet gateway to Rt

resource "aws_route_table" "Name" {
    vpc_id = var.vpc_id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id 
     
  }
  
}
#subent associations
resource "aws_route_table_association" "name" {
    route_table_id = var.route_table_id 
    subnet_id = var.subnet_id
  
}

# Security group

resource "aws_security_group" "Name" {
  name        = "allow_tls"
  vpc_id      = var.vpc_id
  tags = {
    Name = "server_sg"
  }
 ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }


egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }


  }

  resource "aws_instance" "Name" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.subnet_id
    associate_public_ip_address = true
    security_groups = [ var.security_groups ]
 
    tags = {
      Name = "server 4"
    }
}