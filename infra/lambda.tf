# Zip the code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../package"
  output_path = "${path.module}/lambda_function.zip"
}

# Create the Lambda function
resource "aws_lambda_function" "processor" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "ImageProcessor"
  role          = aws_iam_role.lambda_role.arn
  handler       = "handler.thumbnail_handler"
  runtime       = "python3.11"

  environment {
    variables = {
      DEST_BUCKET = aws_s3_bucket.processed_bucket.id
    }
  }
}

# Give S3 permission to trigger Lambda
resource "aws_lambda_permission" "allow_s3" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.processor.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.source_bucket.arn
}

# The Trigger: Run when a .jpg is uploaded
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.source_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.processor.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".jpg"
  }

  depends_on = [aws_lambda_permission.allow_s3]
}