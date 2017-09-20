provider "aws" {
  region = "eu-west-2"
}

module "website" {
  source = "../../"

  name     = "my-first-website"
  hostname = "example.com"

  tags {
    Domain = "example.com"
    Owner  = "webmaster@example.com"
  }
}
