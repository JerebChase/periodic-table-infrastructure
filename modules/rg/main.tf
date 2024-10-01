resource "aws_resourcegroups_group" "periodic-table-rg" {
  name = "periodic-table-rg-${var.env}"

  

  tags = {
    env = "${var.tag}"
  }
}