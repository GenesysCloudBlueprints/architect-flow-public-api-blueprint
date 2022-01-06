variable "did_numbers" {
    type = list(string)
    description = "The phone numbers that route to our flow (should be defined in order)"
}

variable "primary_queue_member_ids" {
    type        = list(string)
    description = "IDs of the members in the primary queue"
}

variable "secondary_queue_member_ids" {
    type        = list(string)
    description = "IDs of the members in the secondary queue"
}

variable "archy_flow_file" {
    type        = string
    description = "The name of the YAML file containing the exported archy flow."
    default     = "archy_flow.yml"
}

