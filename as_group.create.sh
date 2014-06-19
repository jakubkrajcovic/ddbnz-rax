#!/bin/bash

http POST https://identity.api.rackspacecloud.com/v2.0/tokens < auth_token.json
http POST https://syd.autoscale.api.rackspacecloud.com/v1.0/${OS_TENANT_NAME}/groups/ X-Auth-Token:$TOKEN < example.policy.json
