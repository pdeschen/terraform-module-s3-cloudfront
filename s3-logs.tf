resource "aws_s3_bucket" "logs" {
  bucket = "s3-cloudfront-${lower(var.name)}-logs"
  acl    = "log-delivery-write"

  lifecycle_rule {
    id      = "s3-cloudfront-${lower(var.name)}-logs-transitions"
    enabled = true

    transition {
      days          = "${var.logs_transition_ia}"
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = "${var.logs_transition_glacier}"
      storage_class = "GLACIER"
    }

    expiration {
      days = "${var.logs_expiration}"
    }
  }

  tags = "${merge(var.tags, map("Name", format("s3-cloudfront-%s-logs", var.name)))}"
}

resource "aws_s3_bucket_policy" "logs" {
  bucket = "${aws_s3_bucket.logs.id}"
  policy = "${data.aws_iam_policy_document.s3_bucket_logging.json}"
}

data "aws_iam_policy_document" "s3_bucket_logging" {
  statement {
    sid    = "AllowCurrentUserFullAccess"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "${data.aws_caller_identity.current.arn}",
      ]
    }

    actions = [
      "s3:*",
    ]

    resources = [
      "${aws_s3_bucket.logs.arn}",
      "${aws_s3_bucket.logs.arn}/*",
    ]
  }
}
