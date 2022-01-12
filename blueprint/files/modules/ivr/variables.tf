variable "did_numbers" {
    type        = list(string)
    description = "The phone numbers that route to our flow (should be defined in order)"
}

variable "architect_flow_id" {
    type        = string
    description = "The ID of the inbound call flow."
}