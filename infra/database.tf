resource "aws_dynamodb_table" "image_metadata" {
  name         = "ImageProcessingLogs"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ImageID"

  attribute {
    name = "ImageID"
    type = "S"
  }
}