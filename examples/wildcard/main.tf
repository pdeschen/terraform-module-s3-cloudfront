provider "aws" {
  region = "eu-west-2"
}

module "website" {
  source = "../../"

  name         = "my-first-website"
  hostname     = "mysite.example.com"
  wildcard_ssl = "*.example.com"

  tags {
    Domain = "mysite.example.com"
    Owner  = "webmaster@example.com"
  }
}
