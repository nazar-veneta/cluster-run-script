#!/bin/bash

#Specify id of your instaces
instid1=i-00d6e4d2a4ee40444 #Master
instid2=i-06eb528e81ff5d862 #Worker1
instid3=i-04f6fc3de5af5bba8 #Worker2

#getting old and new ip of instances
oldip=$(cat ~/.script/oldip.txt)
newip=$(cat ~/.script/newip.txt)

if [ "$newip" = "$oldip" ]
then
    #starts master and workers instances
    echo "Starting up cluster..."
    aws ec2 start-instances --instance-ids "$instid1" "$instid2" "$instid3" 1> /dev/null

    #whaits master instance to boot up
    aws ec2 wait instance-running --instance-ids "$instid1" "$instid2" "$instid3"
    echo "Cluster is running"

    #getting ip of master instance
    inst1ip=$( aws ec2 describe-instances --instance-ids "$instid1" \
        --query 'Reservations[*].Instances[*].PublicIpAddress' --output text )
    echo "Cluaster public IPv4 is $inst1ip"

    newip=$inst1ip
    echo "$newip" > ~/.script/newip.txt

    #replace old ip of cluster to new ip of cluster in config file
    sed -i "s/$oldip/$newip/g" ~/.kube/config
    echo "Configuration updated"
    echo "Done"
else
    echo "Error. Something went wrong, check your settings"
fi