provider "aws" {
  region = "us-east-1"  # Change as needed
}

# Security Group for Web Server
resource "aws_security_group" "web_sg" {
  name        = "web-security-group"
  description = "Allow inbound HTTP and SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change to a restricted IP range for security
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance (Web Server)
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Terraform Web Server</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Web-Server"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "db-security-group"
  description = "Allow inbound MySQL access from Web Server"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]  # Correct for RDS Security Group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



# RDS MySQL Instance
resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t4g.micro"
  username           = var.db_username
  password           = var.db_password
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot = true

  tags = {
    Name = "MySQL-Database"
  }
}
