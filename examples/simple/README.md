# Example Usage

The example in this directory is the recommended minimum needed to setup this
module (i.e. `name` and `hostname`).

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

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money (logs stored
within S3, for example). Run `terraform destroy` when you don't need these
resources.
