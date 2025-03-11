Terraform Web Application Infrastructure

Overview

This repository contains Terraform code to provision a web application infrastructure on AWS. The setup includes:

An EC2 web server running Apache
A MySQL database with restricted access
Proper security groups for controlled traffic

Infrastructure Diagram

┌───────────────────────────┐         ┌───────────────────────┐
│        Web Server         │  --->   │    MySQL Database     │
│ (EC2 + Apache + index.html)│         │  (RDS with SG rules) │
└───────────────────────────┘         └───────────────────────┘
       |                            
       |                            
   Security Group → Allows only necessary traffic
   
Deployment Instructions

1. Prerequisites

Ensure you have the following installed:

Terraform (≥ v1.0.0)
AWS CLI (configured with credentials)
Git

2. Clone the Repository
   
git clone <url of repo>

4. Configure Terraform Variables
   
Modify the terraform.tfvars file to set up required values:


aws_region = "us-east-1"
instance_type = "t2.micro"
db_username = "admin"
db_password = "yourpassword"


4. Initialize Terraform

terraform init

5. Plan & Apply the Infrastructure

terraform plan
terraform apply -auto-approve

6. Get the Web Server IP

terraform output web_server_public_ip
Open a browser and visit:

http://<public-ip>
You should see:

Terraform Web Server

Resources Used

Resource	Purpose: 
aws_instance	Deploys the web server
aws_security_group	Manages inbound/outbound rules
aws_db_instance	Creates a MySQL database
user_data	Automates web server setup

Customization
Modify the following files if needed:

variables.tf → Define/change input variables
terraform.tfvars → Set values for variables
main.tf → Adjust infrastructure as required

Verification & Logs
To Check Deployment Logs

terraform show
To Destroy the Infrastructure

terraform destroy -auto-approve





