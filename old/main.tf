# locals {
#   bucket_settings = {
#     {versioning = true, id = "Delete after 2 days", days = 2, number=1},
#     {versioning = true, id = "Delete after 2 days", days = 2, number=2},
#     {versioning = true, id = "Delete after 2 days", days = 2, number=3},
#   }
# }
variable "buckets" {
  default = ["devopsengineeringcerta-1", "devopsengineeringcerta-2", "devopsengineeringcerta-3"]
}

locals {
  bucket_settings = {
    devopsengineerincerta-1 = { versioning = true, id = "Delete after 2 days", lifecycle_rules = [{ enabled = true, id = "Delete after 2 days", expiration = { days = 2 } }], bucket = 0 },
    #devopsengineerincerta-2 = { versioning = true, id = "Delete after 4 days", lifecycle_rules = [{ enabled = true, id = "Delete after 4 days", expiration = { days = 4 } }], bucket = 1 },
    #devopsengineerincerta-3 = { versioning = true, id = "Delete after 6 days", lifecycle_rules = [{ enabled = true, id = "Delete after 6 days", expiration = { days = 6 } }], bucket = 2 }
  }
}

resource "aws_s3control_bucket_lifecycle_configuration" "example" {
  for_each = local.bucket_settings
  bucket   = "arn:aws:s3:::devopsengineeringcerta-1"
  rule {
    id = lookup(each.value, "id", null)
    expiration {
      days = lookup(each.value, "days", null)
    }
  }
}

# resource "aws_s3_bucket" "buckets" {
#   for_each = local.bucket_settings
#   bucket   = lookup(each.value,"bucket",null)
#   versioning {
#     enabled = each.value.versioning
#   }
#   # tags = {
#   #   Environment = each.value.Environment
#   # }
#   dynamic "lifecycle_rule" {
#     for_each = length(each.value.lifecycle_rules) > 0 ? each.value.lifecycle_rules : []
#     iterator = rule

#     content {
#       enabled = lookup(rule.value, "enabled", null)
#       id      = lookup(rule.value, "id", null)
#       dynamic "expiration" {
#         for_each = length(keys(lookup(rule.value, "expiration", {}))) == 0 ? [] : [rule.value.expiration]
#         content {
#           days = lookup(expiration.value, "days", null)
#         }
#       }
#     }
#   }
# }
