#!/bin/bash
ssht(){
echo "###############################################"
echo "##------Script to SSH Timeout on IN nodes----##"
echo "##--Name:Issahaku Kamil | UserID : EKAMISS---##"
echo "###############################################"

#Configure SSH Session Timeout
echo ""
echo "You are required to set the SSH timeout for an ongoing SSH session."
echo "Please enter the required value for the SSH timeout."
read timout
echo "Do you want to set the SSH timeout value to $timout seconds? yes/no"
echo ""
read ans
ans=${ans^^}
file=/etc/ssh/sshd_config

if [[ "$ans" == "YES" ]]
then
        sed -i 's/.*ClientAliveInterval.*/ClientAliveInterval '$timout' /g' $file
	status="$?"
        if [[ "$status" == "0" ]]
        then
                echo ""     
                echo "ClientAliveInterval is set to '$timout' seconds"
                echo ""
        elif [[ "$status" == "1" ]]
        then
        #Rollback if the action is not successful
                echo ""
                echo "Failed to set ClientAliveInterval,please try again :-)"
        else
                echo ""
                echo "exit status=$status"
                echo ""
        fi
elif [[ "$ans" == "NO" ]]
then
        echo ""
        echo "No value set for SSH timeout"
        echo ""
else
        echo "Please enter either yes or no"
fi

#Set ClientAliveCountMax
echo ""
echo "You are required to enter the value for the Duration of an Alive Client SSH Session"
echo ""
read count
echo ""
echo "Do you want to set $count as the Client Alive Count? yes/no"
echo ""
read alive
alive=${alive^^}
if [[ "$alive" == "YES" ]]
then
        sed -i 's/.*ClientAliveCountMax.*/ClientAliveCountMax '$count'/g' $file
        status="$?"
        if [[ "$status" == "0" ]]
        then
                echo ""
                echo "ClientAliveCountMax is set to $count seconds"
                echo ""
		
		systemctl restart sshd
		status="$?"
		if [[ "$status" == "0" ]]
		then
        		echo ""
        		echo "SSH has been Restarted Successfully"
        		echo ""
		elif [[ "$status" == "1" ]]
		then
        		#Rollback if the action is not successful
        		echo ""
        		echo "<<<<<<<<<<<<Failed to Restart SSH..Trying again>>>>>>>>>"
        		echo ""
        		systemctl restart sshd
		else
        		echo ""
        		echo "exit status=$status"
        		echo ""
		fi
        elif [[ "$status" == "1" ]]
        then
                #Rollback if the action is not successful
                echo ""
                echo "Failed to set ClientAliveCountMax,please try again :-)"
                echo ""
        else
                echo ""
                echo "exit status=$status"
                echo ""
        fi
elif [[ "$alive" == "NO" ]]
then
        echo ""
        echo "ClientAliveCount has not been set"
        echo ""
else
        echo "Please enter yes/no to continue"
fi

. rollback.sh
roll
}

