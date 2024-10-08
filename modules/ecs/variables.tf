variable "ecs_role_arn" {
    description = "The arn of the ecs task execution role"
    type        = string
}

variable "ecr_repository_url" {
    description = "The url for the ecr repository"
    type        = string
}

variable "periodic_table_subnet" {
    description = "The subnet for the periodic table VPC"
    type        = string
}

variable "periodic_table_sg" {
    description = "The security group for the periodic table VPC"
    type        = string
}