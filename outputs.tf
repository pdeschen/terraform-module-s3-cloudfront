output "hostname" {
  value = "https://${var.hostname}/"
}

output "s3_bucket_name" {
  value = "${aws_s3_bucket.content.id}"
}

output "cloudfront_distribution_id" {
  value = "${aws_cloudfront_distribution.website.id}"
}

output "cloudfront_distribution_hostname" {
  value = "${aws_cloudfront_distribution.website.domain_name}"
}
