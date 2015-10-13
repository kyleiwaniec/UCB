#!/bin/bash

# xx.x.xxx.xx  <- your elastic ip
# vol-xxxxxxxx   <- your volume id
# you need to choose your own security group which has open ports: 8080,8088,4040,50070,22,8020

# launch (availability-zone = us-east-1b, securitygroup = ucb_205_security_group, ami = ucbw205_complete_plus_postgres)

NEWINSTACEID="$(aws ec2 run-instances --image-id ami-bff58fda --key ucb --instance-type m3.large --security-group-ids sg-a5e90ec3 --subnet subnet-bcf5bd97 --query 'Instances[*][InstanceId]' --output text)"

check_status=$(aws ec2 describe-instance-status --instance-ids $NEWINSTACEID --query 'InstanceStatuses[*].InstanceState.Name' --output text)


until [ "$check_status" == "running" ]; do
	echo "checking..."
	sleep 1
	check_status=$(aws ec2 describe-instance-status --instance-ids $NEWINSTACEID --query 'InstanceStatuses[*].InstanceState.Name' --output text)
done


# set elastic ip. you can do this first, one time through he AWS console
aws ec2 associate-address --instance-id $NEWINSTACEID --public-ip xx.x.xxx.xx

# attach my volume 
aws ec2 attach-volume --volume-id vol-xxxxxxxx --instance-id $NEWINSTACEID --device /dev/sdf

# Go Play! root @ elastic ip
ssh -i "your_key.pem" root@xx.x.xxx.xx

#TODO: write bootsrap.sh
#/root/start_hadoop.sh
#/data/start_postgres.sh
#su – w205