variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-04b4f1a9cf54c11d0" 
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  default = "ChangeMe123!"  # ⚠️ Use AWS Secrets Manager instead of hardcoding
}
