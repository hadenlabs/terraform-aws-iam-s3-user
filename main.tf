locals {
  input = {
    enabled       = var.enabled
    force_destroy = var.force_destroy
    name          = var.name
    namespace     = var.namespace
    path          = var.path
    stage         = var.stage
    use_fullname  = var.use_fullname
    tags          = var.tags
    s3_actions    = var.s3_actions
    s3_resources  = var.s3_resources
  }
}

locals {

  generated = {
    enabled       = local.input.enabled
    force_destroy = local.input.force_destroy
    name          = local.input.name
    namespace     = local.input.namespace
    path          = local.input.path
    stage         = local.input.stage
    use_fullname  = local.input.use_fullname
    tags          = local.input.tags
    s3_actions    = local.input.s3_actions
    s3_resources  = local.input.s3_resources
  }

}

locals {

  outputs = {
    enabled       = local.generated.enabled
    force_destroy = local.generated.force_destroy
    namespace     = local.generated.namespace
    path          = local.generated.path
    stage         = local.generated.stage
    use_fullname  = local.generated.use_fullname
    name          = local.generated.name
    tags = merge(local.generated.tags, {
      Name = local.generated.name
    })
    s3_actions   = local.generated.s3_actions
    s3_resources = local.generated.s3_resources
  }
}

module "s3_user" {
  source        = "hadenlabs/iam-system-user/aws"
  version       = "0.1.1"
  enabled       = local.outputs.enabled
  force_destroy = local.outputs.force_destroy
  path          = local.outputs.path
  namespace     = local.outputs.namespace
  stage         = local.outputs.stage
  name          = local.outputs.name
  use_fullname  = local.outputs.use_fullname
  tags          = local.outputs.tags
}

resource "aws_iam_user_policy" "this" {
  depends_on = [
    module.s3_user,
  ]
  #bridgecrew:skip=BC_AWS_IAM_16:Skipping `Ensure IAM policies are attached only to groups or roles` check because this module intentionally attaches IAM policy directly to a user.
  count  = local.outputs.enabled ? 1 : 0
  name   = module.s3_user.user_name
  user   = module.s3_user.user_name
  policy = join("", data.aws_iam_policy_document.this.*.json)
}
