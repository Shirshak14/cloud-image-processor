resource "aws_s3_bucket" "source_bucket" {
  bucket = "shirshak-bucket-cloud223" # Make this unique!
  force_destroy  = true  # <--- Add this line
}

resource "aws_s3_bucket" "processed_bucket" {
  bucket = "my-unique-resized-images-2026"
  force_destroy  = true  # <--- Add this line
}