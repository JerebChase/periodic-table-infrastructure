resource "aws_ecr_repository" "periodic_table_repo" {
  name = "periodic-table-api"
  tags = {
    env: "${var.tag}"
  }
}