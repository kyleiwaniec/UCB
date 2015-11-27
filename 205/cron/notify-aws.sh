#!/bin/bash

INSTANCE_STATUS="$(/usr/local/bin/aws ec2 describe-instance-status --query 'InstanceStatuses[*]' --output text)"

if [[ "$INSTANCE_STATUS" == "" ]]; then
	echo "$INSTANCE_STATUS"
else
	echo "$INSTANCE_STATUS"
	osascript -e 'display notification "You got some AWS shit running" with title "AWS" sound name "Blow.aiff"'
	return 1
fi		

#osascript -e 'literal stuff goes here; '"stuff with $parameters here"' more literal stuff'
