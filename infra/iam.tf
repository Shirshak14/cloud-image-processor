# 1. The "Assume Role" Policy: Allows the Lambda service to use this role
resource "aws_iam_role" "lambda_role" {
  name = "image_processor_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# 2. The Permissions Policy: What the Lambda is actually allowed to do
resource "aws_iam_role_policy" "lambda_policy" {
  name = "image_processor_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Permission to READ from the Source Bucket
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "${aws_s3_bucket.source_bucket.arn}",
          "${aws_s3_bucket.source_bucket.arn}/*"
        ]
      },
      # Permission to WRITE to the Processed Bucket
      {
        Effect   = "Allow"
        Action   = [
          "s3:PutObject"
        ]
        Resource = [
          "${aws_s3_bucket.processed_bucket.arn}",
          "${aws_s3_bucket.processed_bucket.arn}/*"
        ]
      },
      # Permission to write logs to CloudWatch (Crucial for debugging!)
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      # Permission to write metadata to DynamoDB
      {
        Effect   = "Allow"
        Action   = [
          "dynamodb:PutItem"
        ]
        Resource = "${aws_dynamodb_table.image_metadata.arn}"
      }
    ]
  })
}