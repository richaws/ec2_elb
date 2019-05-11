variable "ssh_key" {
  type = "string"
  description = "SSH Public Key"
}

variable "ami" {
  type = "string"
  description = "AMI for Web"
  default = "ami-0de53d8956e8dcf80"
}

variable "instance_type" {
  type = "string"
  description = "instance type to use"
  default = "t2.micro"
}

variable "max_capacity" {
  type = "string"
  description = "Max ASG Capacity"
  default = "1"
}

variable "min_capacity" {
  type = "string"
  description = "Min ASG Capacity"
  default = "1"
}

variable "desired_capacity" {
  type = "string"
  description = "Desired ASG Capacity"
  default = "1"
}