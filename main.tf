module "assume_role_policy" {
  source    = "app.terraform.io/ptonini-org/iam-policy/aws"
  version   = "~> 1.0.0"
  statement = var.assume_role_policy_statement
}

module "policy" {
  source    = "app.terraform.io/ptonini-org/iam-policy/aws"
  version   = "~> 1.0.0"
  statement = var.policy_statement
}

resource "aws_iam_role" "this" {
  name                 = var.name
  max_session_duration = var.max_session_duration
  assume_role_policy   = module.assume_role_policy.json_statement
}

resource "aws_iam_role_policy" "this" {
  count  = length(var.policy_statement) > 0 ? 1 : 0
  role   = aws_iam_role.this.id
  policy = module.policy.json_statement
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each   = { for i, v in var.policy_arns : i => v }
  role       = aws_iam_role.this.id
  policy_arn = each.value
}