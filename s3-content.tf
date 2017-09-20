resource "aws_s3_bucket" "content" {
  bucket = "s3-cloudfront-${lower(var.name)}-content"
  acl    = "public-read"

  versioning {
    enabled = true
  }

  website {
    index_document = "${var.index_document}"
    error_document = "${var.error_document}"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["https://${var.hostname}"]
    expose_headers  = ["ETag"]
    max_age_seconds = "${var.cache_ttl}"
  }

  lifecycle_rule {
    id      = "s3-cloudfront-${lower(var.name)}-content"
    enabled = true

    noncurrent_version_expiration {
      days = 7
    }
  }

  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "${var.hostname}/s3"
  }

  tags = "${merge(var.tags, map("Name", format("s3-cloudfront-%s-content", var.name)))}"
}

resource "aws_s3_bucket_policy" "content" {
  bucket = "${aws_s3_bucket.content.id}"
  policy = "${data.aws_iam_policy_document.s3_bucket_content.json}"
}

data "aws_iam_policy_document" "s3_bucket_content" {
  statement {
    sid    = "AllowCloudFrontObjectRead"
    effect = "Allow"

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.content.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.website.iam_arn}"]
    }
  }

  statement {
    sid    = "AllowCloudFrontBucketList"
    effect = "Allow"

    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.content.arn}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.website.iam_arn}"]
    }
  }

  statement {
    sid    = "AllowCurrentUserFullAccess"
    effect = "Allow"

    principals = {
      type = "AWS"

      identifiers = [
        "${data.aws_caller_identity.current.arn}",
      ]
    }

    actions = [
      "s3:*",
    ]

    resources = [
      "${aws_s3_bucket.content.arn}",
      "${aws_s3_bucket.content.arn}/*",
    ]
  }
}
