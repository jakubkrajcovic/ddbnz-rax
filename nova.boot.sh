#!/bin/bash
#
# This script sets up a basic environment of 2 servers - one a DNS server and the other a chef server
# This is to be used with the cloud account jakubksyd02 that is rackconnected to account 1701012
# as part of a hybrid cloud demo and lab environment
#
# Jakub Krajcovic, Rackspace 10/02/2014
#
#
# Image to use: 28b21a55-b686-4e8e-be9b-b6df2aaf60b8 - Ubuntu 12.04 PVHVM
# Flavors: 
#   DNS: 3 (1GB)
#   Chef: 4 (4GB)
# userdata: chef-userdata.sh
#           dns-userdata.sh
# Key name: jaku6388
# config-drive: true
#
# DNS domain: 
# How to add to an F5 load balancer pool: --meta RackConnectF5Pool=$POOL


export OS_AUTH_URL=https://identity.api.rackspacecloud.com/v2.0/
export OS_AUTH_SYSTEM=rackspace
export OS_REGION_NAME=SYD
export OS_USERNAME=XXXX
export OS_TENANT_NAME=XXXX
export OS_TENANT_ID=XXXX
export NOVA_RAX_AUTH=1
export NOVA_OS_PASSWORD=XXXX
export OS_PASSWORD="XXXX"
export OS_PROJECT_ID=XXXX
export OS_NO_CACHE=1
export REGION=syd

IMAGEID=$(cat ./image-id)
KEY=ddbnz
P11=performance1-1
P12=performance1-2
P14=performance1-4
P18=performance1-8

alias nova="nova --os-password ${NOVA_OS_PASSWORD} "


# Boot and bootstrap utility server
nova --os-password ${NOVA_OS_PASSWORD} boot --flavor  ${P11} --image ${IMAGEID} --key-name ${KEY} --config-drive true --file /root/.bash_functions=./bootstrap/personality/bash_functions --file /root/.openrc/ddbnz-warehouse=./bootstrap/personality/ddbnz-warehouse --file /root/.raxrc=./bootstrap/personality/raxrc --disk-config MANUAL --user-data ./bootstrap/cloudinit/default/combined-userdata.txt utility
# Boot and bootstrap the admin server
nova --os-password ${NOVA_OS_PASSWORD} boot --flavor  ${P12} --image ${IMAGEID} --key-name ${KEY} --config-drive true --file /root/.bash_functions=./bootstrap/personality/bash_functions --file /root/.openrc/ddbnz-warehouse=./bootstrap/personality/ddbnz-warehouse --file /root/.raxrc=./bootstrap/personality/raxrc --disk-config MANUAL --user-data ./bootstrap/cloudinit/default/combined-userdata.txt admin

# boot and bootstrap redis
nova --os-password ${NOVA_OS_PASSWORD} boot --flavor  ${P14} --image ${IMAGEID} --key-name ${KEY} --config-drive true --file /root/.bash_functions=./bootstrap/personality/bash_functions --file /root/.openrc/ddbnz-warehouse=./bootstrap/personality/ddbnz-warehouse --file /root/.raxrc=./bootstrap/personality/raxrc --disk-config MANUAL --user-data ./bootstrap/cloudinit/redis/combined-userdata.txt redis-master
nova --os-password ${NOVA_OS_PASSWORD} boot --flavor  ${P14} --image ${IMAGEID} --key-name ${KEY} --config-drive true --file /root/.bash_functions=./bootstrap/personality/bash_functions --file /root/.openrc/ddbnz-warehouse=./bootstrap/personality/ddbnz-warehouse --file /root/.raxrc=./bootstrap/personality/raxrc --disk-config MANUAL --user-data ./bootstrap/cloudinit/redis/combined-userdata.txt redis-slave

# boot and bootstrap the basis for what will become the node.js golden image
nova --os-password ${NOVA_OS_PASSWORD} boot --flavor  ${P14} --image ${IMAGEID} --key-name ${KEY} --config-drive true --file /root/.bash_functions=./bootstrap/personality/bash_functions --file /root/.openrc/ddbnz-warehouse=./bootstrap/personality/ddbnz-warehouse --file /root/.raxrc=./bootstrap/personality/raxrc --disk-config MANUAL --user-data ./bootstrap/cloudinit/nodejs/combined-userdata.txt nodeapp01
