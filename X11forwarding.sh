#!/bin/bash
X11(){
echo "###################################################"
echo "##---Script to Enable X11Forwarding on IN nodes--##"
echo "##-----Name:Issahaku Kamil | UserID : EKAMISS----##"
echo "###################################################"
file=/etc/ssh/sshd_config
#Set X11Forwarding to "yes"
echo ""
echo "Please do you want to enable X11forwarding? yes/no"
echo ""
read xfor
xfor=${xfor^^}
if [[ "$xfor" == "YES" ]]
then
	echo "Setting X11forwarding to yes.."
	sed -i 's/.*X11Forwarding .*/X11Forwarding yes/g;' $file
	status="$?"
	#Check if Action was successful
        if [[ "$status" == "0" ]]
        then
                echo ""
                echo "X11fForwarding has been set to yes"
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
		else
        		echo ""
        		echo "exit status=$status"
        		echo ""
		fi
        elif [[ "$status" == "1" ]]
        then
                echo ""
                echo "Failed to set X11Forwarding to yes,please try again :-)"
        else
                echo ""
                echo "exit status=$status"
                echo ""
        fi
elif [[ "$xfor" == "NO" ]]
then
	echo "Aborting Operation.."
else
	echo "exit status=$status"
fi

. rollback.sh
roll
}

