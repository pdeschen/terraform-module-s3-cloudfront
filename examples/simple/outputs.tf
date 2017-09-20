output "hostname" {
  value = "${module.website.hostname}"
}

output "s3_bucket_name" {
  value = "${module.website.s3_bucket_name}"
}

output "s3_bucket_url" {
  value = "${module.website.s3_bucket_url}"
}

output "cloudfront_distribution_id" {
  value = "${module.website.cloudfront_distribution_id}"
}

output "cloudfront_distribution_hostname" {
  value = "${module.website.cloudfront_distribution_hostname}"
}
