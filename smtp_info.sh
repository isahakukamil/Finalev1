#!/bin/bash

#---MOP WORK PACKAGE TAG: WP041V3---
#---DESC:
#---THIS SCRIPT WILL PREVENT SMTP INFORMATION DISCLOSURE---

#---SCRIPT BY REUBEN A. BOAKYE---
#---SIGNUM: EBOAREU---



#---Backup of config file is created with timestamp if config file exists
#and config file 'sendmail.cf' is edited afterwards---

smtp_info () {
	file=/etc/mail/sendmail.cf

	if test -f "$file"; then
		timestamp=$(date '+%m_%y_%H_%M_%S')
		fextension=".cf"
		fextension1=".log"
		backupfile=/etc/mail/$timestamp$fextension
		logname="script"
		logfile=/var/log/$logname$fextension1

		cp /etc/mail/sendmail.cf /etc/mail/$backupfile

		sed -i '/.*O PrivacyOptions.*/c\O PrivacyOptions=goaway,restrictmailq,restrictqrun,noreceipts,restrictexpand,noetrn,nobodyreturn' $file

		#This tests if logfile is already created.
		if test -f "$logFile"; then 
			if [ $STATUS -eq 0 ]; then
				echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
				sudo service sendmail restart
			else
				echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
				mv $backupfile $file
			fi
		else
			sudo touch $logFile
			if [ $STATUS -eq 0 ]; then
				echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
				sudo service sendmail restart
			else
				echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
				sudo mv $backupfile $file
			fi
		fi
	else 
		echo "***THE CONFIGURATION FILE DOES NOT EXIST!***"
	fi

}


