resource "aws_resourcegroups_group" "periodic-table-rg" {
  name = "periodic-table-rg-${var.env}"

  resource_query {
    query = jsonencode({
      "Type"       : "TAG_FILTERS_1_0",
      "Query"      : {
        "TagFilters" : [
          {
            "Key"    : "env",
            "Values" : ["${var.tag}"]
          }
        ]
      }
    })
  }

  tags = {
    env: "${var.tag}"
  }
}