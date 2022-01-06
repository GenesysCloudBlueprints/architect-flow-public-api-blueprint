variable "name" {
    type        = string
    description = "Name of the queue."
}

variable "description" {
    type        = string
    description = "Description of the queue."
}

variable "queue_member_ids" {
    type        = list(string)
    description = "IDs of the queue members."
    default     = []
}

variable "auth_division_name" {
    type        = string
    description = "The name of the Genesys Cloud auth division."
    default     = "Home"
}