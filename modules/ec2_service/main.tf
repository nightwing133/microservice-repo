# EC2 Security Group allowing HTTPS access directly (optional)
resource "aws_security_group" "instance" {
  name        = "terraform-instance-sg"
  description = "Allow HTTPS access to EC2"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "terraform-instance-sg" }
}

# IAM Role for EC2 instance
resource "aws_iam_role" "ec2_role" {
  name = "EC2MicroserviceRole"

  assume_role_policy = <<-POLICY
  {
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {"Service": "ec2.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }]
  }
  POLICY
}

# IAM instance profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

# EC2 Instance
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = concat(var.security_group_ids, [aws_security_group.instance.id])
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    systemctl enable docker
    systemctl start docker
  EOF

  tags = { Name = "secure-ec2-instance" }
}

# ECR Repository
resource "aws_ecr_repository" "microservice_repo" {
  name = "microservice"
  image_scanning_configuration { scan_on_push = true }
  tags = { Name = "microservice_ecr_repo" }
}