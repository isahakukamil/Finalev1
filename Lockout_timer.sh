#!/bin/bash

Lock(){
echo ""
echo "#########################################################"
echo "##----Bash Script to Set Lockout Timer on IN nodes-----##"
echo "##---------Name:Issahaku Kamil | UserID : EKAMISS------##"
echo "#########################################################"

file6=/etc/pam.d/system-auth
file7=/etc/pam.d/password-auth
#Create a backup directory,extract and append timestamp to backup filename and copy files to new backup file
if grep -Fxq "LockoutBackup" /tmp 2&>/dev/null
then
	echo ""
	echo "Backup of /etc/pam.d/system-auth is stored at /tmp/LockoutBackup directory"
	echo ""
else
	mkdir /tmp/LockoutBackup 2&>/dev/null
	echo ""
        echo "Backup of /etc/pam.d/system-auth is stored at /tmp/LockoutBackup directory"
        echo ""
fi


ExtrTimeStamp=$(date "+%Y-%m-%d_%H-%M-%S")
echo ""
echo "Note the Date-Time-Stamp in case of a rollback:$ExtrTimeStamp"
echo ""

touch /tmp/LockoutBackup/LockoutBackup1.$ExtrTimeStamp
touch /tmp/LockoutBackup/LockoutBackup2.$ExtrTimeStamp

cp -r $file6 /tmp/LockoutBackup/LockoutBackup1.$ExtrTimeStamp
cp -r $file7 /tmp/LockoutBackup/LockoutBackup2.$ExtrTimeStamp

#Set Max Login Attempts
echo ""
echo "Please Enter the maximum login attempts to be set"
echo ""
read maxlog
echo "Please Enter value for unlock time after login attempts fail"
read unlotime
if grep -Fxq "file=/var/log/tallylog deny=$maxlog even_deny_root unlock_time=$unlotime" $file6
then 
	echo ""
	echo "Maximum of $maxlog login attempts has been set with unlock time of $unlotime seconds"
	echo ""

else
	echo "file=/var/log/tallylog deny=$maxlog even_deny_root unlock_time=$unlotime" >> $file6
	echo ""
        echo "Maximum of $maxlog login attempts has been setp with unlock time of $unlotime"
        echo ""
fi

if grep -Fxq "file=/var/log/tallylog deny=$maxlog even_deny_root unlock_time=$unlotime" $file7
then
        echo ""
        echo "Maximum of $maxlog login attempts has been setp with unlock time of $unlotime seconds"
        echo ""

else
        echo "file=/var/log/tallylog deny=$maxlog even_deny_root unlock_time=$unlotime" >> $file7
        echo ""
fi
echo "Restarting ssh ..."
systemctl restart sshd;
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

. rollback.sh
roll
}

