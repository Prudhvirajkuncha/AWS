provider "aws" {
    access_key = "AKIA52FBS5XD7CDPUZX7"
    secret_key = "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"
    region = "us-east-1"
}
resource "aws_cloudwatch_event_rule" "ec2-pending" {
  name = "capture-ec2-pending"
  description = "Captures event when an ec2 instance enters pending state"
  event_pattern = <<PATTERN
{
  "source": [ "aws.ec2" ],
  "detail-type": [ "EC2 Instance State-change Notification" ],
  "detail": {
    "state": [ "pending" ]
  }
}
PATTERN
}
#resource "aws_cloudwatch_event_target" "lambda" {
#  rule = aws_cloudwatch_event_rule.ec2-pending.name
#  target_id = "Ec2PendingEvent"
#  arn = aws_lambda_function.Ec2-StateChange-Lambda.arn
#}
#output "arn" { 
#  value = aws_lambda_function.Ec2-StateChange-Lambda.arn 
#}