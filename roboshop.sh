#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-08225e8104187ede6"  # replace with your SG ID

for instance in $@
do  
INSTANCE_ID=$(aws ec2 run-instances --image-id ami-0220d79f3f480ecf5 --instance-type t3.micro --security-group-ids sg-08225e8104187ede6 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query "Instances[0].InstanceId" --output text)

#get private IP
    if [ $instance != "frontend" ]; then 
    IP=$(aws ec2 describe-instances --instance-ids i-02a5c4c70d8fd0bf8 --query 'Reservations[].Instances[].PrivateIpAddress' --output text)

    else
        IP=$(aws ec2 describe-instances --instance-ids i-02a5c4c70d8fd0bf8 --query 'Reservations[].Instances[].PublicIpAddress' --output text)
fi
echo "$instace: $IP"
done
