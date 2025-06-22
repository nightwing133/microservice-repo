variable "ami_id" {
  type        = string
  description = "AMI ID for EC2"
  default     = "ami-0230bd60aa48260c6"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for EC2 instance"
}

variable "security_group_ids" {
  type        = list(string)
  description = "SG IDs attached to EC2"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for EC2 resources"
}