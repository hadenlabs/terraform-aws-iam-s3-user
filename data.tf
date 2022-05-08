data "aws_iam_policy_document" "this" {
  count = local.outputs.enabled ? 1 : 0

  statement {
    actions   = local.outputs.s3_actions
    resources = local.outputs.s3_resources
    effect    = "Allow"
  }
}
