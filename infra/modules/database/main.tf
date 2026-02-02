resource "aws_dynamodb_table" "url_table" {
  name         = "${var.project_name}-urls"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "URLID"

  attribute {
    name = "URLID"
    type = "S"
  }

  tags = {
    Name = "${var.project_name}-urls"
  }
}
