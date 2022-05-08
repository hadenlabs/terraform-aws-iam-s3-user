# How to use this project

```hcl
module "main" {
  source  = "hadenlabs/iam-s3-user/aws"
  version = "0.0.0"

  depends_on   = []
  enabled      = var.enabled
  name         = var.name
  stage        = var.stage
  namespace    = var.namespace
  tags         = var.tags
  use_fullname = var.use_fullname
  s3_actions   = [
    "s3:ListAllMyBuckets",
  ]
  s3_resources = [
    "arn:aws:s3:::bucket-name/*",
  ]
}
```
