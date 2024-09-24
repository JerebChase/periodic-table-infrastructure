resource "aws_resourcegroups_group" "periodic-table-rg" {
  name = "test-group"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::EC2::Instance"
  ],
  "TagFilters": [
    {
      "Key": "env",
      "Values": ["${var.tag}"]
    }
  ]
}
JSON
  }

  tags = {
    env: "${var.tag}"
  }
}