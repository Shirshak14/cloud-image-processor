# Serverless Image Processing Pipeline

An event-driven AWS architecture that automatically resizes images upon upload. This project demonstrates Infrastructure as Code (IaC) using Terraform, serverless computing with AWS Lambda, and metadata persistence with DynamoDB.

## 🏗️ Architecture
1. **S3 Source Bucket**: User uploads a `.jpg` image.
2. **S3 Event Notification**: Triggers the Lambda function.
3. **AWS Lambda (Python)**: Resizes the image using the `Pillow` library.
4. **S3 Processed Bucket**: Lambda saves the thumbnail version here.
5. **DynamoDB**: Lambda logs image metadata (filename, size, timestamp).
6. **CloudWatch**: Stores execution logs for debugging and monitoring.



## 🛠️ Tech Stack
- **Infrastructure:** Terraform (IaC)
- **Cloud Provider:** AWS (S3, Lambda, DynamoDB, IAM, CloudWatch)
- **Language:** Python 3.9+
- **Libraries:** Pillow (Image Processing), Boto3 (AWS SDK)
- **Cost Management:** Infracost

## 🚀 Getting Started

### Prerequisites
- AWS CLI configured with appropriate permissions.
- Terraform installed.
- Python installed (for local packaging).

### Deployment
1. Clone the repository:
   ```bash
   git clone [https://github.com/YOUR_USERNAME/cloud-image-processor.git](https://github.com/YOUR_USERNAME/cloud-image-processor.git)
   cd cloud-image-processor/infra
