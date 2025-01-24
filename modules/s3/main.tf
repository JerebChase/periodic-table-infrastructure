resource "aws_s3_bucket" "periodic_table_bucket" {
  bucket = "periodic-table-${var.env}"
  
  tags = {
    env = "${var.tag}"
  }
}

resource "aws_s3_object" "periodic_table_object" {
  bucket = aws_s3_bucket.periodic_table_bucket.bucket
  key    = "periodic-table-import.csv"
  source = "periodic-table-import.csv"

  tags = {
    env = "${var.tag}"
  }
}