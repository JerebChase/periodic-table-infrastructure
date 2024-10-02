variable "periodic_table_vpc_link" {
    description = "The VPC link for the periodic table"
    type        = string
}

variable "periodic_table_lb_dns_name" {
    description = "The dns anme for the network load balancer"
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