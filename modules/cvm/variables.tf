variable "secret_id" {
  default = "Your Access ID"
}

variable "secret_key" {
  default = "Your Access Key"
}

variable "regoin" {
  default = "ap-hongkong"
}

variable "availability_zone" {
  default = "ap-hongkong-2"
}

variable "instance_charge_type" {
  type    = string
  default = "SPOTPAID"
}


variable "tags" {
  description = "A map of the tags to use for the resources that are deployed"
  type        = map(string)

  default = {
    # This value will be the tage text.
    web = "tf-web"
    dev = "tf-dev"
  }
}

# VPC Info
variable "short_name" {
  default = "tf-vpc"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "vpc_id" {
  default = ""
}

variable "subnet_id" {
  default = ""
}

# ECS insance variables 
variable "image_id" {
  default = ""
}

variable "instance_name" {
  default = "terraform-cvm-k8s"
}

variable "password" {
  default = "password123"
}

variable "cpu" {
  default = "2"
}

variable "memory" {
  default = "4"
}