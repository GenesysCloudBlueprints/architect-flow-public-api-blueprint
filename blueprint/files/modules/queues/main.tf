terraform {
    required_providers {
        genesyscloud = {
            source = "mypurecloud/genesyscloud"
        }
    }
}

resource "genesyscloud_routing_queue" "queue" {
    name        = var.name
    division_id = data.genesyscloud_auth_division.division.id
    description = var.description

    acw_wrapup_prompt        = "OPTIONAL"
    skill_evaluation_method  = "NONE"
    enable_transcription     = false
    enable_manual_assignment = false

    # Add members 
    dynamic "members" {
        for_each = var.queue_member_ids
        content {
            user_id = members.value
        }
    }
}

data "genesyscloud_auth_division" "division" {
    name = var.auth_division_name
}