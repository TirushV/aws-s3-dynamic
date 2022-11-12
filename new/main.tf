locals {
  bucket_settings = {
    devopsengineerincerta-1 = { versioning = true, lifecycle_rules = [{ enabled = true, id = "Delete after 2 days", expiration = { days = 2 } }] },
    devopsengineerincerta-2 = { versioning = true, lifecycle_rules = [{ enabled = true, id = "Delete after 4 days", expiration = { days = 4 } }] },
    devopsengineerincerta-3 = { versioning = true, lifecycle_rules = [{ enabled = true, id = "Delete after 6 days", expiration = { days = 6 } }] }
  }
}

resource "aws_s3_bucket" "buckets" {
  #for_each = local.bucket_settings
  bucket = "devopsengineeringcerta-1"
  versioning {
    enabled = true
  }
#   tags = {
#     Environment = "A"
#   }
  lifecycle_rule {
    id      = "Delete after 7 days"
    enabled = true
    expiration {
      days = 7
    }
  }
}
resource "aws_s3_bucket" "bucket2" {
  #for_each = local.bucket_settings
  bucket = "devopsengineeringcerta-2"
  versioning {
    enabled = true
  }
#   tags = {
#     Environment = "B"
#   }
  lifecycle_rule {
    id      = "Delete after 7 days"
    enabled = true
    expiration {
      days = 7
    }
  }
}
resource "aws_s3_bucket" "bucket3" {
  #for_each = local.bucket_settings
  bucket = "devopsengineeringcerta-3"
  versioning {
    enabled = true
  }
#   tags = {
#     Environment = "C"
#   }
  lifecycle_rule {
    id      = "Delete after 7 days"
    enabled = true
    expiration {
      days = 7
    }
  }
}