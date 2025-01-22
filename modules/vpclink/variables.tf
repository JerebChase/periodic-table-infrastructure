variable "periodic_table_sgs" {
    description = "The security groups for the periodic table vpc"
    type        = string
}

variable "periodic_table_subnets" {
    description = "The subnets for the periodic table vpc"
    type        = string
}

variable "tag" {
    description = "The tag to apply to AWS resources"
    type        = string
}

variable "env" {
    description = "The environment"
    type        = string
}