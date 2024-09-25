variable "periodic_table_cluster" {
    description = "The cluster name for ecs"
    type        = string
}

variable "periodic_table_service" {
    description = "The service name for ecs"
    type        = string
}

variable "tag" {
    description = "The tag to apply to AWS resources"
    type        = string
}