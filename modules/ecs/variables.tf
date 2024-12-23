variable "ecs_task_role_arn" {
    description = "The arn of the ecs task execution role"
    type        = string
}

variable "periodic_table_lb_arn"{
    description = "The arn of the application load balancer"
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

variable "ecs_sg" {
    description = "The security group for the ecs on the periodic table VPC"
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