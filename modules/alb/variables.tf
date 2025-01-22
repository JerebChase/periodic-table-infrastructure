variable "periodic_table_vcp_id" {
    description = "The id of the periodic table VPC"
    type        = string
}

variable "periodic_table_subnets" {
    description = "The subnets for the periodic table VPC"
    type        = list
}

variable "alb_sg" {
    description = "The security group for the alb on the periodic table VPC"
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