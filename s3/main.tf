resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.aws_vpc_endpoint
  service_name = "com.amazonaws.ap-southeast-1.s3"
}

resource "aws_s3_bucket" "laravel-bucket122abc" {
  bucket = "laravel-bucket123abc"

  tags = {
    Name        = "${var.bucket_name}"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.laravel-bucket122abc.id
  acl    = var.acl
}

resource "aws_s3_bucket_object" "nginx-bo" {
  bucket = aws_s3_bucket.laravel-bucket122abc.id
  key    = "nginx.txt"
  acl    = "private"  
  source = "./s3/nginx.txt"
  etag = filemd5("./s3/nginx.txt")
}

resource "aws_s3_bucket_object" "env-bo" {
  bucket = aws_s3_bucket.laravel-bucket122abc.id
  key    = "env.txt"
  acl    = "private"  
  source = "./s3/env.txt"
  etag = filemd5("./s3/env.txt")
}
