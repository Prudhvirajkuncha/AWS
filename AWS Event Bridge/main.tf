provider "aws" {
    access_key = "" #Place your access key
    secret_key = "" #Place your secret key
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