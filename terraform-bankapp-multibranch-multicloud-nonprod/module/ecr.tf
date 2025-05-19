resource "aws_ecr_repository" "ecr" {
  count = 2
  name                 = "bankapp-${count.index + 1}"
  image_tag_mutability = "MUTABLE"   ### "IMMUTABLE"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = false   ### true
  }

  encryption_configuration {
    encryption_type = "AES256"   ### "KMS"
#    kms_key = ""
  }
}
