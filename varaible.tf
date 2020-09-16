# EC2 and Elastic search variable

variable "aws_region" {
  description = "Region for the VPC"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "192.168.0.0/16"
}

variable "pub_subnet_cidr" {
  description = "CIDR for the public subnet"
  default     = "192.168.0.0/24"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default     = "ami-0c94855ba95c71c99"
}

/*
variable "key_path" {
  description = "SSH Public Key path"
  default     = "public_key"
}
*/
variable namespace {
  type        = string
  default     = "devops-test-state"
  description = "Name of the S3 bucket to store state files"
}


variable "es_domain" {
  type        = string
  default     = "nikhil-devopstest"
  description = "ElasticSearch domain name"
}

