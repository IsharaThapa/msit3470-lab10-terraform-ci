

resource "aws_s3_bucket" "warmup" {
  bucket = "ishara-terraform-warmup-${random_id.suffix.hex}"
  tags = {
    Name    = "Warmup S3 Bucket"
    Purpose = "Terraform Test"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}
