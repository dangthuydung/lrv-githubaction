
# resource "aws_s3_bucket" "terraform-state" {
#     bucket = "terraform-state-dungdang"
#     acl    = "private"

#     lifecycle {
#     prevent_destroy =true
#     }

#     versioning {
#     enabled =  true
#     }

#     server_side_encryption_configuration {
#     rule {
#         apply_server_side_encryption_by_default {
#         sse_algorithm     = "AES256"
#         }
#     }
#     }
# }
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





