#!/bin/sh

# setup and start the rackspace monitoring agent
API_KEY=XXXX
USERNAME=XXXX

rackspace-monitoring-agent --setup --username ${USERNAME} --apikey ${API_KEY}
service rackspace-monitoring-agent start
chkconfig rackspace-monitoring-agent on

# install rackspace nova client
pip install rackspace-novaclient
# install the raxmon cli
pip install rackspace-monitoring-cli

# configure some basic checks for the cloud monitoring
ENTITY=$(raxmon-entities-list | grep label=$(hostname) | awk -F "=" '{print($2); }' | awk '{print($1); }')
raxmon-checks-create --entity-id=${ENTITY} --label=load --type agent.load_average --details "Load average"

service redis-server restart
