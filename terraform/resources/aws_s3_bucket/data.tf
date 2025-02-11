data "aws_iam_policy_document" "main" {
  depends_on = [aws_s3_bucket.s3_bucket]
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.project]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.s3_bucket.arn,
      "${aws_s3_bucket.s3_bucket.arn}/*",
    ]
  }
}
