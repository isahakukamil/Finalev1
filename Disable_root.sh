#!/bin/bash

disable_root() {
echo "#############################################################"
echo "##-----Script to Disable Root Access via SSH on IN nodes---##"
echo "##----------Name:Issahaku Kamil | UserID : EKAMISS---------##"
echo "#############################################################"

#Create a backup directory,extract and append timestamp to backup filename and copy files to new backup file

file=/etc/ssh/sshd_config
if grep -Fxq "SSHConfigBack" /tmp 2&>/dev/null
then
	echo ""
	echo "The backup of /etc/ssh/sshd_config is stored in /tmp/SSHConfigBack directory...."
	echo ""

else
	mkdir /tmp/SSHConfigBack/ 2&>/dev/null
	echo ""
fi

ExtrTimeStamp=$(date "+%Y-%m-%d_%H-%M-%S");
echo ""
echo "Note the Date-Time-Stamp in case of a rollback:$ExtrTimeStamp"
echo ""

touch /tmp/SSHConfigBack/RootSSHConfigBackup.$ExtrTimeStamp;
cp -r $file /tmp/SSHConfigBack/RootSSHConfigBackup.$ExtrTimeStamp;

#Set the securetty file to empty to prevent direct login from any device
echo ""
echo "Do you wish to disable root login via SSH? yes/no"
echo ""
read disp
disp=${disp^^}
if [[ "$disp" == "YES" ]]
then
	echo > /etc/securetty;
	status="$?"
	if [[ "$status" == "0" ]]
	then
		echo ""
		echo "Securetty File has been cleared to prevent Direct login via console"
		echo ""
	elif [[ "$status" == "1" ]]
	then 
		echo ""
		echo "Clearing of securetty file has not been successful"
		echo ""
	else
		echo ""
		echo "Exit status=$status"
		echo ""
	fi

	echo ""
	echo "Enter yes/no to either permit or deny Root Login via SSH"
	echo ""
	read permit
	permit=${permit^^}
	if [[ "$permit" == "YES" ]]
	then
        	sed -i 's/.*PermitRootLogin.*/PermitRootLogin '$permit'/g' $file
        	status="$?"
        	if [[ "$status" == "0" ]]
        	then
                	echo "PermitRootLogin is set to $permit"
			systemctl restart sshd;
			status="$?"
			if [[ "$status" ==  "0" ]]
			then
        			echo ""
        			echo "SSH has been Restarted Successfully"
        			echo ""
			elif [[ "$status" == "1" ]]
			then
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
                	echo "Failed to set  PermitRootLogin to $permit"
        	else
                	echo "exit status=$status, Please try again"
        	fi
	elif [[ "$permit" == "NO" ]]
	then
        	sed -i 's/.*PermitRootLogin.*/PermitRootLogin '$permit'/g' $file
        	status="$?"
        	if [[ "$status" == "0" ]]
        	then
                	echo "PermitRootLogin is set to $permit"
                        systemctl restart sshd;
                        status="$?"
                        if [[ "$status" ==  "0" ]]
                        then
                                echo ""
                                echo "SSH has been Restarted Successfully"
                                echo ""
                        elif [[ "$status" == "1" ]]
                        then
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
                	echo "Failed to set  PermitRootLogin to $permit"
       	 	else
                	echo "exit status=$status, Please try again"
        	fi
	else
        	echo "Please set either yes/no to continue"
	fi
elif [[ "$disp" == "NO" ]]
then
	echo ""
	echo "Aborting Operation.."
	echo "Operation Aborted"
	echo ""
else
	echo "Please Enter either yes/no"
fi
. rollback.sh
roll
} 

