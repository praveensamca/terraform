resource "aws_s3_bucket" "example" {
  bucket = "mlflowpraveen"

  tags = {
    Name        = "mlflowpraveen"
    Environment = "Dev"
  }
}


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_object" "object" {
  bucket = resource.aws_s3_bucket.example.id
  key    = "/home/Salary_Data.csv"
  source = "./Salary_Data.csv"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  #etag = filemd5("./cities.csv")
}
