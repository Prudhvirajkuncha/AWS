provider "aws" {
    access_key = "AKIA52FBS5XD7CDPUZX7"
    secret_key = "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"
    region = "us-east-1"
}
resource "aws_servicecatalog_portfolio" "Terraform_Test_Portfolio" {
  name  = "terraform Portfolio"
  description = "list of Services"
  provider_name = "Prudhvi"
}
resource "aws_servicecatalog_product" "s3_bucket" {
  name  = "S3 Bucket"
  owner = "Prudhvi"
  type  = "CLOUD_FORMATION_TEMPLATE"

  provisioning_artifact_parameters {
    template_url = "https://service-catalog-cftemplates.s3.amazonaws.com/S3+Bucket.json"
    name = "Simple S3 Bucket"
    description = "v1.0"
    type = "CLOUD_FORMATION_TEMPLATE"
  }
}
resource "aws_servicecatalog_product_portfolio_association" "product_portfolio_association" {
  portfolio_id = aws_servicecatalog_portfolio.Terraform_Test_Portfolio.id
  product_id = aws_servicecatalog_product.s3_bucket.id
}
resource "aws_servicecatalog_principal_portfolio_association" "iam_role_association" {
  portfolio_id = aws_servicecatalog_portfolio.Terraform_Test_Portfolio.id
  principal_arn = "arn:aws:iam::949526654407:user/Terraform-user"
}
#resource "aws_servicecatalog_portfolio_share" "accounts_portfolio_share" {
#  principal_id = "ACCOUNT NUMBER - TO SHARE"
#  portfolio_id = "aws_servicecatalog_portfolio.Terraform_Test_Portfolio.id"
#}
data "aws_servicecatalog_launch_paths" "s3_product_path" {
  product_id = aws_servicecatalog_product.s3_bucket.id
}
resource "aws_servicecatalog_provisioned_product" "s3_provisioned_product_kit" {
  name = "S3-Bucket"
  product_id = aws_servicecatalog_product.s3_bucket.id
  path_id = data.aws_servicecatalog_launch_paths.s3_product_path.summaries[0].path_id
  provisioning_artifact_name = aws_servicecatalog_product.s3_bucket.provisioning_artifact_parameters[0].name
}