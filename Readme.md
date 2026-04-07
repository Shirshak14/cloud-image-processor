🚀 Serverless Image Processing Pipeline
An automated, event-driven pipeline built with Terraform that resizes images in real-time. This project handles the full lifecycle of an image—from upload to thumbnail generation and metadata logging.

🏗️ Architecture Overview
This system follows a decoupled, serverless architecture:

Trigger: User uploads a .jpg to the Source S3 Bucket.

Compute: S3 triggers an AWS Lambda function via Event Notifications.

Process: Lambda (Python/Pillow) fetches the image, generates a thumbnail, and uploads it to the Processed S3 Bucket.

Log: Metadata (Size, Type, Timestamp) is persisted in DynamoDB.

Observe: All execution logs and errors are streamed to Amazon CloudWatch.

🛠️ Tech Stack & DevOps Tools
IaC: Terraform (Modular & Scalable)

Cloud: AWS (S3, Lambda, DynamoDB, IAM)

CI/CD: GitHub Actions (Automated terraform plan on every push)

FinOps: Infracost (Pre-deployment cost estimation)

Language: Python 3.9 (Boto3 & Pillow)

📁 Project Structure
Plaintext
.
├── .github/workflows/    # CI/CD Pipeline (GitHub Actions)
├── infra/                # Terraform Configuration Files
│   ├── main.tf           # Provider & Global Config
│   ├── s3.tf             # Storage Buckets
│   ├── lambda.tf         # Serverless Logic & Triggers
│   └── iam.tf            # Security Roles & Policies
├── package/              # Deployment Artifacts
│   └── handler.py        # Python Image Logic
└── Readme.md
🚀 Deployment Guide
Prerequisites
AWS CLI configured (aws configure)

Terraform v1.0+

Python 3.9+

Step-by-Step
Clone the Repo

Bash
git clone https://github.com/Shirshak14/cloud-image-processor.git
cd cloud-image-processor/infra
Initialize & Plan

Bash
terraform init
terraform plan
Deploy to AWS

Bash
terraform apply -auto-approve
📈 Monitoring & Costs
Infracost: Total estimated monthly cost is $0.00 (within AWS Free Tier limits).

CloudWatch Logs: Accessible via the /aws/lambda/ImageProcessor log group.

🛡️ Security & Best Practices
Least Privilege: IAM roles are scoped strictly to specific S3 buckets and DynamoDB tables.

CI/CD Safety: Infrastructure changes are planned automatically in GitHub Actions before manual deployment.

State Management: .gitignore ensures sensitive .tfstate files are never leaked.

Created by Shirshak
