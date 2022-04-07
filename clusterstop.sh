#!/bin/bash

#Specify id of your instaces
instid1=i-xxx #Master
instid2=i-xxx #Worker1
instid3=i-xxx #Worker2

#getting new and old ip
oldip=$(cat ~/.script/oldip.txt)
newip=$(cat ~/.script/newip.txt)

if [ "$newip" != "$oldip" ]
then
    echo "Shutting down..."
    #starts master and workers instances
    aws ec2 stop-instances --instance-ids "$instid1" "$instid2" "$instid3" 1> /dev/null

    #whaits master instance to boot up
    aws ec2 wait instance-stopped --instance-ids "$instid1" "$instid2" "$instid3"
    echo "$newip" > ~/.script/oldip.txt
    echo "Cluaster is stopped"
    echo "Done"
else
    echo "Error. Something went wrong, check your settings"
fi
