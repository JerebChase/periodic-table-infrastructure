resource "aws_resourcegroups_group" "periodic-table-rg" {
  name  = "periodic-table-rg-${var.env}"
  resource_query {
    query = <<JSON
{
    "TagFilters": [
        {
        "Key": "env",
        "Values": ["dev"]
        }
    ]
}
JSON
  }

  tags = {
    env = "${var.tag}"
  }
}