##Amazon Infrastructure
provider "aws" {
  region = var.aws_region
}

##Create security group
resource "aws_security_group" "ms_architecture_sg" {
  name        = "ms-architecture_sg"
  vpc_id      = var.aws_vpc_id
  description = "Allow all inbound traffic necessary for k8s"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags = {
    Name = "ms-architecture_sg"
  }
}

##Find latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

##Create k8s Master Instance
resource "aws_instance" "aws-ms-architecture" {
  subnet_id              = var.aws_subnet_id
  depends_on             = [aws_security_group.ms_architecture_sg]
  ami                    = "ami-066c6938fb715719f"
  instance_type          = var.aws_instance_size
  vpc_security_group_ids = [aws_security_group.ms_architecture_sg.id]
  key_name               = var.aws_key_name
  count                  = var.aws_master_count
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = true
  }
  tags = {
    Name = "adv-docker-${count.index}"
    role = "ms-architecture"
  }
}

output "ms-architecture-public_ips" {
  value = [aws_instance.aws-ms-architecture.*.public_ip]
}

