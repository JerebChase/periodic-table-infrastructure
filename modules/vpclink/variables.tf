variable "periodic_table_lb_arn" {
    description = "The arn of the network lb"
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