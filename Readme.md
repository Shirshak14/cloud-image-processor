# 🚀 Serverless Image Processing Pipeline
[![Terraform Action](https://github.com/Shirshak14/cloud-image-processor/actions/workflows/terraform.yaml/badge.svg)](https://github.com/Shirshak14/cloud-image-processor/actions/workflows/terraform.yaml)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat&logo=terraform&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)

An automated, event-driven pipeline built with **Terraform** that resizes images in real-time. This project handles the full lifecycle of an image—from upload to thumbnail generation and metadata logging.

## 🏗️ Architecture Overview
This system follows a **decoupled, serverless architecture**:
1.  **Trigger**: User uploads a `.jpg` to the Source S3 Bucket.
2.  **Compute**: S3 triggers an **AWS Lambda** function via Event Notifications.
3.  **Process**: Lambda (Python/Pillow) fetches the image, generates a thumbnail, and uploads it to the Processed S3 Bucket.
4.  **Log**: Metadata (Size, Type, Timestamp) is persisted in **DynamoDB**.
5.  **Observe**: All execution logs and errors are streamed to **Amazon CloudWatch**.

## 🛠️ Tech Stack & DevOps Tools
* **IaC:** Terraform (Modular & Scalable)
* **Cloud:** AWS (S3, Lambda, DynamoDB, IAM, CloudWatch)
* **CI/CD:** GitHub Actions (Automated `terraform plan` on every push)
* **FinOps:** Infracost (Pre-deployment cost estimation)
* **Language:** Python 3.9 (Boto3 & Pillow)

## 📁 Project Structure
```text
.
├── .github/workflows/    # CI/CD Pipeline (GitHub Actions)
├── infra/                # Terraform Configuration Files
│   ├── main.tf           # Provider & Global Config
│   ├── s3.tf             # Storage Buckets
│   ├── lambda.tf         # Serverless Logic & Triggers
│   └── iam.tf            # Security Roles & Policies
├── package/              # Deployment Artifacts
│   └── handler.py        # Python Image Logic
└── Readme.md             # Project Documentation
