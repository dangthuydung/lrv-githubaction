resource "aws_s3_bucket" "terraform-state" {
    bucket = "terraform-state1234599"
    acl    = "private"

    lifecycle {
    prevent_destroy =true
    }

    versioning {
    enabled =  true
    }

    server_side_encryption_configuration {
    rule {
        apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
        }
    }
    }
}
