#!/bin/bash

Disable_Weak_CBC() {
echo "#############################################################"
echo "##----Script to Disable Weak SSH CBC Ciphers on IN nodes---##"
echo "##--------Name:Issahaku Kamil | UserID : EKAMISS-----------##"
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

if grep -Fxq "Disable_root_logs" /var/log 2&>/dev/null
then 
	echo ""
	echo "Your actions will be logged in the /var/log/Disable_root_logs directory"
	echo ""
else
	mkdir /var/log/Disable_root_logs 2&>/dev/null
	echo ""
	echo "Your actions will be logged in the /var/log/Disable_root_logs directory"
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
echo "Do you wish to disable weak ssh mode ciphers? yes/no"
echo ""
read disp
disp=${disp^^}
if [[ "$disp" == "YES" ]]
then
	echo "Ciphers aes128-ctr,aes192-ctr,aes256-ctr" >> /etc/ssh/sshd_config
	echo "MACs hmac-sha1,umac-64@openssh.com,hmac-ripemd160" >> /etc/ssh/sshd_config	
	status="$?"
	if [[ "$status" == "0" ]]
	then
		echo ""
		echo "Weak SSH CBC Mode Ciphers have been disabled"
		echo ""
		systemctl restart sshd;
		status="$?"
		if [[ "$status" ==  "0" ]]
		then
        		echo "SSH has been Restarted Successfully"
        		echo ""
		elif [[ "$status" == "1" ]]
		then
        		echo "<<<<<<<<<<<<Failed to Restart SSH..Trying again>>>>>>>>>"
        		echo ""
		else
        		echo "exit status=$status"
        		echo ""
		fi
	elif [[ "$status" == "1" ]]
	then 
		echo "Failed to diable weak cbc mode ciphers"
		echo ""
	else
		echo "Exit status=$status"
		echo ""
	fi

elif [[ "$disp" == "NO" ]]
then
	echo "Aborting Operation.."
	echo "Operation Aborted"
else
	echo "exit status=$status"
fi
. rollback.sh
roll
} 

