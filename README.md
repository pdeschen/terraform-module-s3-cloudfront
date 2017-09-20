# AWS S3/CloudFront Website Terraform Module

This is a [Terraform](https://www.terraform.io) module which creates
CloudFont-enabled S3 bucket for a static website with logging and object
life-cycle management.

## Important

This module will create an encrypted (i.e. HTTPS) endpoint in CloudFront using
[Amazon Certificate Manager](https://aws.amazon.com/certificate-manager/). ACM
cannot be automated at this time as it requires manual steps in the approval
of the domain name before it can be added into the account. Please therefore
setup the certificate for the domain name you require (and any aliases you may
include as well) by following the
[Getting Started](http://docs.aws.amazon.com/acm/latest/userguide/gs.html) guide
in the AWS Documentation.

## Usage

```hcl
provider "aws" {
  region = "eu-west-2"
}

module "website" {
  source = "modules/terraform-module-s3-cloudfront"

  name     = "my-first-website"
  hostname = "example.com"
  aliases  = [
  	"example.net",
  	"example.org"
  ]

  cache_ttl = 86400

  logs_transition_ia      = 30
  logs_transition_glacier = 60
  logs_expiration         = 365

  price_class = "PriceClass_100"

  index_document = "index.html"
  error_document = "error.html"

  tags {
    Domain = "example.com"
    Owner  = "webmaster@example.com"
  }
}
```

## Examples

A simple example of how to use this module can be found in the
[examples/](https://github.com/jonathanio/terraform-module-s3-cloudfront/tree/master/examples)
directory of this repository.

## Authors

Jonathan Wright <jon@than.io>

## License

MIT Licensed. See LICENSE for full details.
