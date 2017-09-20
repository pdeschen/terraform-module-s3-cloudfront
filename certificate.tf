/* CloudFront is based out of us-east-1, so when making any lookups for
   Certificates, they must look them up in that region, not in the local region
   we're building in. As such, arrange for the frontend certificate below to
   be selected from us-east-1 instead. */

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

data "aws_acm_certificate" "frontend" {
  provider = "aws.us-east-1"
  domain   = "${var.hostname}"
}
