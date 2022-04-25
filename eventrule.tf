resource "aws_cloudwatch_event_rule" "Findings-EventRule" {
  name        = "${var.project}-Findings-EventRule"
  description = "Capture GuardDuty Findings"
  is_enabled     = true
  event_pattern = <<EOF
{
  "source": ["aws.guardduty"],
  "detail-type": ["GuardDuty Finding"]
}
EOF
}

resource "aws_cloudwatch_event_target" "sns_topic" {
  rule      = aws_cloudwatch_event_rule.Findings-EventRule.name
  arn       = aws_sns_topic.guardduty_sns_topic.arn
  input_transformer {
    input_paths = {
        Account_ID = "$.detail.accountId",
        Finding_ID   = "$.detail.id",
        Finding_Type = "$.detail.type",
        Finding_description   = "$.detail.description",
        region = "$.region",
        severity   = "$.detail.severity"
    }
    input_template = <<EOF
"AWS <Account_ID> has a severity <severity> GuardDuty finding type <Finding_Type> in the <region> region."
"Finding Description:"
"<Finding_description>. "
"For more details open the GuardDuty console at https://console.aws.amazon.com/guardduty/home?region=<region>#/findings?search=id=<Finding_ID>"
EOF
  }
}