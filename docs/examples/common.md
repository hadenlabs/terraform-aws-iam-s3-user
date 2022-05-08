<!-- Space: Projects -->
<!-- Parent: TerraformAwsIamS3User -->
<!-- Title: Examples TerraformAwsIamS3User -->

<!-- Label: Examples -->
<!-- Include: ./../disclaimer.md -->
<!-- Include: ac:toc -->

### common

```hcl
  module "main" {
    source  = "hadenlabs/iam-s3-user/aws"
    version = "0.1.0"
  }
```

## Basic

### data

```hcl
module "main" {
  source  = "hadenlabs/iam-s3-user/aws"
  version = "0.1.0"
  depends_on   = []
  enabled      = var.enabled
  name         = var.name
  stage        = var.stage
  namespace    = var.namespace
  tags         = var.tags
  use_fullname = true
  s3_actions   = [
    "s3:GetObject",
		"s3:GetObjectAcl",
		"s3:ListObjects",
		"s3:ListBucket",
		"s3:ListAllMyBuckets",
  ]
  s3_resources = [
		"arn:aws:s3:::bucket-name/*",
  ]
}
```
