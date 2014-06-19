#!/bin/bash

# Jakub Krajcovic, Rackspace, 10/02/2014
# Rackspace cloud monitoring setup is done in 2 ways:
# We first have to setup some account-wide settings and then we configure checks and alarms per each instance
# 
# The 2 things that are "account-wide" that we need to setup are: notifications and notification plans

###############
# Notifications
#raxmon-notifications-create --label=notification-email-general --type=email --details="address=jakub@rackspace.com"
#Resource created. ID: ntgPhlUYr9
#EMAILOKNOTIFICATION=ntgPhlUYr9

#raxmon-notifications-create --label=notification-email-escalation --type=email --details="address=jakub@rackspace.com"
#Resource created. ID: ntsICnRxUx
#EMAILCRITICALNOTIFICATION=ntsICnRxUx

#raxmon-notifications-create --label=notification-webhook-as-group-webservers-scale-up --type=webhook --details="url=http://autoscale.api.rackspacecloud.com/as-group-web/scale-up"
#Resource created. ID: ntzS9yFExw
#AUTOSCALEWEBUP=ntzS9yFExw

#raxmon-notifications-create --label=notification-webhook-as-group-webservers-scale-down --type=webhook --details="url=http://autoscale.api.rackspacecloud.com/as-group-web/scale-down"
#Resource created. ID: ntbzLtdFfz
#AUTOSCALEWEBDOWN=ntbzLtdFfz

#####################
# Notifications plans
#raxmon-notification-plans-create --label=notificationplan-email --ok-state=ntgPhlUYr9 --critical-state=ntsICnRxUx
# Resource created. ID: npQg0NyyEZ
# raxmon-notification-plans-create --label=notificationplan-as-group-webservers --ok-state=ntbzLtdFfz --critical-state=ntzS9yFExw
# Resource created. ID: npAeLUMh7k
