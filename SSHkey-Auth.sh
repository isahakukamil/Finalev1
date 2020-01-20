#!/bin/bash
keyb(){
echo "#########################################################################"
echo "##-----Bash Script to Enforce Key-based Authentication on IN nodes-----##"
echo "##---------------Name:Issahaku Kamil | UserID : EKAMISS----------------##"
echo "#########################################################################"

#Create a backup directory,extract and append timestamp to backup filename and copy files to new backup file

file11=/etc/ssh/sshd_config

if grep -Fxq "SSHConfiBackups" /tmp 2&>/dev/null
then
	exit
else
	mkdir /tmp/SSHConfigBackups
fi

ExtrTimeStamp=$(date "+%Y-%m-%d_%H-%M-%S")
touch /tmp/SSHConfigBack/SSHConfigBackup.$ExtrTimeStamp;
cp -r $file11  /tmp/SSHConfigBackups/SSHConfigBackup.$ExtrTimeStamp

echo ""
echo "Do you want to disable password authentication and enforce key-based authentication? yes/no"
echo ""
read keypas
keypas=${keypas^^}
if [[ "$keypas" == "YES" ]]
then
	echo "checking to see if key based authentication has already been enabled..."
	if grep -Fxq "PasswordAuthentication no" $file11
	then
		echo ""
		echo "Password Authentication has already been disabled. Only key-based authenticatio allowed"
		echo ""
	else
		sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication no/g' $file11
		status="$?"
		if [[ "$status" == "0" ]]
		then
			echo "Key-based Authentication has been enabled successfully"
			echo "Restarting SSH..."
			systemctl restart sshd
			status="$?"
			if [[ "$status" == "0" ]]
			then
				echo "SSH service has been disabled successfully"
			elif [[ "$status" == "1" ]]
			then
				echo "Failed to restart ssh. exiting..."
			else
				echo "exit status=$status"
			fi
		elif [[ "$status" == "1" ]]
		then
			echo "Failed to enable key-based authentication"
		else
			echo "exit status=$status"
		fi
	fi
elif [[ "$keypas" == "NO" ]]
then
	echo ""
	echo "Aborting Operation..."
	echo ""
else
	echo "Wrong input!, Kindly input either yes/no"
	keyb
fi
. rollback.sh
roll
}

