resource "aws_sns_topic" "guardduty_sns_topic" {
  name = "guardduty_sns_topic"
}

resource "aws_sns_topic_subscription" "email_sns_topic_subscription" {
  for_each = var.sns_email_list
  topic_arn = aws_sns_topic.guardduty_sns_topic.arn
  protocol  = "email"
  endpoint  = each.value
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.guardduty_sns_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"
  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        var.account_id,
      ]
    }
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [
      aws_sns_topic.guardduty_sns_topic.arn,
    ]
    sid = "__default_statement_ID"
  }
}