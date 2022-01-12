terraform {
    required_providers {
        genesyscloud = {
            source = "mypurecloud/genesyscloud"
        }
    }
}

resource "genesyscloud_integration_action" "action" {
    name = "Agents Logged Into Queue"

    category       = data.genesyscloud_integration.integration.name
    integration_id = data.genesyscloud_integration.integration.id
    secure         = false

    contract_input = jsonencode({
        "$schema"     = "http://json-schema.org/draft-04/schema#",
        "title"       = "Get Number of Agents Logged Into Queue Request",
        "description" = "A user ID-based request.",
        "type"        = "object",
        "required" = [
            "QueueID"
        ],
        "properties" = {
            "QueueID" = {
                "description" = "The Queue ID.",
                "type"        = "string"
            }
        },
        "additionalProperties" = true
    })
    contract_output = jsonencode({
        "$schema"     = "http://json-schema.org/draft-04/schema#",
        "title"       = "Get Agents Logged Into Queue",
        "description" = "Agents logged into queue. A value > 0 does not guarentee that an interaction sent to this queue will be answered.",
        "type"        = "object",
        "properties" = {
            "total_agents_on_queue" = {
                "description" = "Agents logged into queue. A value > 0 does not guarantee that an interaction sent to this queue will be answered.",
                "type"        = "integer"
            }
        },
        "additionalProperties" = true
    })
    config_request {
        request_url_template = "/api/v2/routing/queues/$${input.QueueID}/users?presence=$esc.url('On Queue')"
        request_type         = "GET"
        headers = {
            UserAgent    = "PureCloudIntegrations/1.0"
            Content-Type = "application/x-www-form-urlencoded"
        }
        request_template = "$${input.rawRequest}"
    }   
    config_response {
        translation_map = {
            total_agents_on_queue =  ".total"
        }
        translation_map_defaults = {}
        success_template         = "{\"total_agents_on_queue\": $${successTemplateUtils.firstFromArray(\"$${total_agents_on_queue}\")}\n}"
    }
}

data "genesyscloud_integration" "integration" {
    name = var.data_actions_integration_name
}