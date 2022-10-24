##General vars
variable "ssh_user" {
  default = "ubuntu"
}

variable "public_key_path" {
  default = "/Users/jruels/.ssh/k8s-test.pub"
}

variable "private_key_path" {
  default = "/Users/jruels/.ssh/k8s-test"
}

##AWS Specific Vars
variable "aws_master_count" {
  default = 1
}

variable "aws_worker_count" {
  default = 0
}

variable "aws_key_name" {
  default = "k8s"
}

variable "aws_instance_size" {
  default = "t3.micro"
}

variable "aws_region" {
  default = "us-west-1"
}

variable "aws_vpc_id" {
  default = "vpc-db4ab4bc"
}

variable "aws_subnet_id" {
  default = "subnet-7c53ff27"
}

##GCE Specific Vars
variable "gce_worker_count" {
  default = 1
}

variable "gce_creds_path" {
  default = "/Users/spencer/gce-creds.json"
}

variable "gce_project" {
  default = "test-project"
}

variable "gce_region" {
  default = "us-central1"
}

variable "gce_instance_size" {
  default = "n1-standard-1"
}

