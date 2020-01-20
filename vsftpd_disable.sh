#!/bin/bash

Disable(){
echo ""
echo "#######################################################" 
echo "##-Script to Disable Root Access via FTP on IN nodes-##"
echo "##---Name:Issahaku Kamil | UserID : EKAMISS----------##"
echo "#######################################################"

#Create a backup directory,extract and append timestamp to backup filename and copy files to new backup file
file1=/etc/vsftpd/vsftpd.conf
file2=/etc/vsftpd/ftpusers
file3=/etc/vsftpd/user_list
file4=/etc/pam.d/vsftpd
if grep -Fxq "VSFTPDBackups" /tmp 2&>/dev/null
then
	echo ""
        echo "Backup of /etc/vsftpd/vsftpd.conf is stored in /tmp/VSFTPDBackups directory"
else
	mkdir /tmp/VSFTPDBackups 2&>/dev/null
	echo ""
fi

ExtrTimeStamp=$(date "+%Y-%m-%d_%H-%M-%S")
echo ""
echo "Note the Date-Time-Stamp in case of a rollback:$ExtrTimeStamp"
echo ""

touch /tmp/VSFTPDBackups/VsftpdBackup.$ExtrTimeStamp
touch /tmp/VSFTPDBackups/FtpUsersBackup.$ExtrTimestamp
touch /tmp/VSFTPDBackups/UserListBackup.$ExtrTimestamp
cp -r $file1 /tmp/VSFTPBackups/VsftpdBackup.$ExtrTimeStamp
cp -r $file2 /tmp/VSFTPDBackups/FtpUsersBackup.$ExtrTimestamp
cp -r $file3 /tmp/VSFTPDBackups/UserListBackup.$ExtrTimestamp
#end

echo ""
echo "Would you like to disable root login via FTP? yes/no"
read disftp
disftp=${disftp^^}
if [[ "$disftp" == "YES" ]]
then
	#Set userlist_enable parameter to yes
	sed -i 's/.* userlist_enable .*/userlist_enable='$status'/g' $file1
	status="$?"
	if [[ "$status" == "0" ]]
	then
		echo ""
        	echo "Userlist_enable has been successfuly set to yes"

        	#Set userlist_deny parameter to yes
		if grep -Fxq "userlist_deny=$status" $file1
		then
			echo ""
        		echo "userlist_deny parameter has been successfully set to yes in ssh config file"
        		echo ""
		else
			echo "userlist_deny=$status" >> $file1
		fi

		if grep -Fxq "root" $file2
		then
        		echo ""
        		echo "root user has been successfully added to the ftpuser config file"
        		echo ""
		else
        		echo "root" >> $file2
		fi      

		if grep -Fxq "root" $file3
		then
        		echo ""
        		echo "root user has been successfully added to the user_list config file"
     			echo ""
		else
        		echo "root" >> $file3
		fi

		#Check if Action was successful
		systemctl restart vsftpd
		status="$?"
		if [[ "$status" ==  "0" ]]
		then
        		echo ""
        		echo "VSFTPD has been Restarted Successfully"
		elif [[ "$status" == "1" ]]
		then
        		echo ""
        		echo "<<<<<<<<<<<<Failed to Restart VSFTPD..Trying again>>>>>>>>>"
		else
       	 		echo ""
        		echo "exit status=$status"
		fi
	elif [[ "$status" == "1" ]]
	then
		echo ""
        	echo "Failed to disable root login via ftp"
        	echo ""
	else
		echo "exit status=$status"
	fi
elif [[ "$disftp" == "NO" ]]
then
	echo "Aborting Operation.."
	echo "Operation Aborted"
else
	echo "Wrong input, Please enter either yes/no"
	Disable
fi

}

