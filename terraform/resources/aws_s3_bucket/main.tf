resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket
  force_destroy = var.force_destroy

  tags = merge(
    {
      "Name"      = "${terraform.workspace}-${var.bucket}"
      Project     = var.project,
      Environment = terraform.workspace
    },
  )
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  count      = 0
  depends_on = [aws_s3_bucket.s3_bucket]
  bucket     = aws_s3_bucket.s3_bucket.id
  policy     = data.aws_iam_policy_document.main.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_server_side_encryption_configuration" {
  depends_on = [aws_s3_bucket.s3_bucket]
  bucket     = aws_s3_bucket.s3_bucket.id

  rule {
    bucket_key_enabled = false
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_ownership_controls" {
  depends_on = [aws_s3_bucket.s3_bucket]
  bucket     = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_cors_configuration" "s3_bucket_cors_configuration" {
  depends_on = [aws_s3_bucket.s3_bucket]
  bucket     = aws_s3_bucket.s3_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_origins = ["*"]
    allowed_methods = [
      "GET",
      "POST",
      "PUT",
      "DELETE",
    ]
    expose_headers  = []
    max_age_seconds = 0
  }
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block" {
  depends_on = [aws_s3_bucket.s3_bucket]
  bucket     = aws_s3_bucket.s3_bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.s3_bucket_ownership_controls,
    aws_s3_bucket_public_access_block.s3_bucket_public_access_block,
  ]

  bucket = aws_s3_bucket.s3_bucket.id
  acl    = var.acl
}

resource "aws_s3_bucket_accelerate_configuration" "s3_bucket_accelerate_configuration" {
  depends_on = [aws_s3_bucket.s3_bucket]
  bucket     = aws_s3_bucket.s3_bucket.id
  status     = var.acceleration_status
}

resource "aws_s3_bucket_request_payment_configuration" "s3_bucket_request_payment_configuration" {
  depends_on = [aws_s3_bucket.s3_bucket]
  bucket     = aws_s3_bucket.s3_bucket.id
  payer      = var.request_payer
}
