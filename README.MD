# AWS EC2 Deployment with Terraform

## Project Objective
This project aims to:

1. Understand AWS core concepts.
2. Launch an EC2 instance manually through the AWS Console.
3. Automate EC2 deployment using Terraform.
4. Document the entire process for reference.

---

## AWS Concepts Reviewed

### Regions & Availability Zones
- **Region:** A geographical area where AWS resources are hosted (e.g., us-east-1).  
- **Availability Zone (AZ):** Isolated locations within a region to enhance redundancy and availability.

### Virtual Private Cloud (VPC)
- A **VPC** is an isolated network in AWS where resources are launched.  
- Provides control over **subnets, routing tables, and gateways**.

### Subnets
- **Public Subnet:** Can access the internet via an Internet Gateway.  
- **Private Subnet:** No direct internet access, typically for backend services.

### Amazon Machine Image (AMI)
- A **pre-configured template** containing the OS and software for EC2.  
- Used **Ubuntu Server 22.04 LTS** in this project.

### EC2 Instances
- **EC2 (Elastic Compute Cloud)** provides virtual servers in AWS.  
- Selected instance type: **t3.micro** (Free Tier eligible).

### Security Groups
- Acts as a **virtual firewall** for instances.  
- Allowed ports:
  - SSH → 22  
  - HTTP → 80 (optional)

### Key Pair
- A **Key Pair** enables secure SSH access to EC2 instances.

### IAM
- **Identity and Access Management (IAM)** controls permissions and access to AWS resources.

---

## Part 1: Manual EC2 Deployment

### Steps Followed
1. Logged into **AWS Management Console**.
2. Navigated to **EC2 → Instances → Launch Instances**.
3. Selected **Ubuntu Server 22.04 LTS** as the AMI.
4. Chose **t3.micro** as the instance type.
5. Used the **default VPC and subnet**.
6. Created a **Security Group**:
   - Allowed SSH from my IP.  
   - Allowed HTTP if required.
7. Selected or created a **Key Pair**.
8. Launched the EC2 instance.

### Outcome
- **Instance Name:** manual-ec2-instance  
- **Instance Type:** t3.micro  
- **AMI Used:** Ubuntu Server 22.04 LTS  

### SSH Connection
```bash
ssh -i "my-key.pem" ubuntu@<manual-ec2-public-ip>
```

### Screenshot
*Insert screenshot of running EC2 instance in AWS Console.*

---

## Part 2: Terraform EC2 Deployment

### Tools Used
- **Terraform CLI**  
- **AWS CLI**  

### Folder Structure
```
Terraform-EC2-Project/
├── main.tf
├── provider.tf
├── README.md
└── screenshots/
```

### Terraform Configuration

#### provider.tf
```hcl
provider "aws" {
  region = "us-east-1"
}
```

#### main.tf
```hcl
# Security Group for SSH and HTTP
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Security group for SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

# EC2 Instance
resource "aws_instance" "terraform_ec2" {
  ami                    = "ami-0dba2cb6798deb6d8" # Replace with your region's Ubuntu 22.04 AMI
  instance_type          = "t3.micro"
  key_name               = "my-key"                # Replace with your key pair
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "terraform-ec2-instance"
  }
}
```

### Terraform Commands
```bash
terraform init    # Initialize Terraform environment
terraform plan    # Preview planned changes
terraform apply   # Deploy EC2 instance
terraform destroy # Remove resources when done
```

### Outcome
- **Instance Name:** terraform-ec2-instance  
- **Instance Type:** t3.micro  
- **AMI Used:** Ubuntu Server 22.04 LTS  

### SSH Connection
```bash
ssh -i "my-key.pem" ubuntu@<terraform-ec2-public-ip>
```

### Screenshot
*Insert screenshot of Terraform `apply` output and EC2 instance in AWS Console.*

---

## Lessons Learned
- Understanding the difference between **manual and automated provisioning**.  
- Hands-on experience with **Terraform workflow**: `init`, `plan`, `apply`, `destroy`.  
- Configured **security groups and key pairs** for EC2 access.  
- Practiced **Infrastructure as Code (IaC)**.

---

## Challenges Faced
- Selecting the **correct AMI** for the AWS region.  
- Configuring **security groups** correctly for SSH and HTTP.  
- Learning Terraform syntax as a beginner.

---

## References
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)  
- [Terraform AWS Provider](https://developer.hashicorp.com/terraform/providers/aws)  
- [Terraform Tutorials](https://developer.hashicorp.com/terraform/tutorials)  
- [AWS Free Tier](https://aws.amazon.com/free/)

---

**Submitted by:** [Ajay Karthickkyean]    
**Date:** [03/02/2026]

This is my first commit on task2 branch for PR.
PR test: adding this line to create a difference.
