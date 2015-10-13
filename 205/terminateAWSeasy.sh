#!/bin/bash
# VERY IMPORTANT: UNOUNT YOUR /DATA BEFORE DETACHING VOLUME!!!

echo -n "YO DAWG!! did you umount your friggin /data [y/n]: "
read answer

# xx.x.xxx.xx  <- your elastic ip
# vol-xxxxxxxx   <- your volume id

if [[ "$answer" == "y" ]]; then
	aws ec2 detach-volume --volume-id vol-xxxxxxxx

	INSTANCE_ID="$(aws ec2 describe-addresses --public-ips xx.x.xxx.xx --query 'Addresses[*][InstanceId]' --output text)"
	aws ec2 terminate-instances --instance-ids $INSTANCE_ID
else
	echo 'go umount yo /data dawg!'
	ssh -i "your_key.pem" root@xx.x.xxx.xx
	return 1
fi