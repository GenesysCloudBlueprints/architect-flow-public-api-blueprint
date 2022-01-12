terraform {
    required_providers {
        genesyscloud = {
            source = "mypurecloud/genesyscloud"
        }
    }
}

resource "genesyscloud_telephony_providers_edges_did_pool" "did_pool" {
    start_phone_number = var.did_numbers[0]
    end_phone_number   = var.did_numbers[length(var.did_numbers)-1]
}

resource "genesyscloud_architect_ivr" "ivr" {
    depends_on         = [genesyscloud_telephony_providers_edges_did_pool.did_pool]
    name               = "Queue Check IVR"
    dnis               = var.did_numbers
    open_hours_flow_id = var.architect_flow_id
}