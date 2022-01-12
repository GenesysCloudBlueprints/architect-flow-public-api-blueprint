terraform {
    required_providers {
        genesyscloud = {
            source  = "mypurecloud/genesyscloud"
        }
    }
}

provider "genesyscloud" {    
    sdk_debug = true
}

module "check_queue_flow" {
    source = "./modules/check-queue-flow"

    archy_flow_file            = "archy_flow.yml"
    did_numbers                = ["+1 234-567-8910"]
    primary_queue_member_ids   = []
    secondary_queue_member_ids = []
}