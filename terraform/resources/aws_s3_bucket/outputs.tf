output "s3_domain_name" {
  value = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
}
output "id" {
  value = aws_s3_bucket.s3_bucket.id
}
output "arn" {
  value = aws_s3_bucket.s3_bucket.arn
}
output "bucket" {
  value = aws_s3_bucket.s3_bucket.bucket
}
