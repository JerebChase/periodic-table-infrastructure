output "periodic_table_s3_bucket" {
    description = "The id for the periodic table upload bucket"
    value       = aws_s3_bucket.periodic_table_bucket.id
}