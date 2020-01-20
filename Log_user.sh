#!/bin/bash

#---MOP WORK PACKAGE TAG: WP038V3---
#---DESC:
#---LOGGING OF USER ACTIVITIES ON OS LEVEL---

#---SCRIPT BY REUBEN A. BOAKYE---
#---SIGNUM: EBOAREU---

#---All scripts run are logged into a single log file called "script.log"
#with file path /var/log/script.log---

user_log () {
	file=/etc/login.defs
	fileNew=/etc/audit/audit.rules


	if test -f "$file"; then
		timeStamp=$(date '+%m_%y_%H_%M_%S')
		fExtension=".defs"
		fExtension1=".log"
		backupFile=/etc/$timeStamp$fExtension
		logName="script"
		logFile=/var/log/$logName$fExtension1

	#This creats a backup of the configuration file.
		sudo cp $file $backupFile

		echo "FAILLOG_ENAB yes" >> $file
		STATUS=`echo "$?"`

	#This tests if logfile is already created.
		if test -f "$logFile"; then 
			if [ $STATUS -eq 0 ]; then
				echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
			else
				echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
				mv $backupfile $file
			fi
		else
			sudo touch $logFile
			if [ $STATUS -eq 0 ]; then
				echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
			else
				echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
				sudo mv $backupfile $file
			fi
		fi
	else 
		echo "***THE CONFIGURATION FILE DOES NOT EXIST!***"
	fi


	if test -f "$fileNew"; then
		timeStamp=$(date '+%m_%y_%H_%M_%S')
		fExtension=".rules"
		fExtension1=".log"
		backupFile=/etc/audit/$timeStamp$fExtension
		logName="script"
		logFile=/var/log/$logName$fExtension1

	#This creats a backup of the configuration file.
		sudo cp $fileNew $backupFile

		echo "-w /var/log/faillog -p wa -k logins" >> $fileNew
		echo "-w /var/log/lastlog -p wa -k logins" >> $fileNew
		echo "-w /var/log/tallylog -p wa -k logins" >> $fileNew
		echo "-w /var/run/faillock -p wa -k logins" >> $fileNew

		STATUS= echo "$?"
		if [ $STATUS -eq 0 ]; then
			echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
			systemctl restart auditd
		else 
			echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
			sudo mv $backupfile $fileNew
		fi
	else 
		echo "***THE CONFIGURATION FILE DOES NOT EXIST!***"
	fi

	#The following verifies that the rules have been loaded

	echo "DONE! DO YOU WANT TO VERIFY IF RULES WERE APPLIED?"
	echo "[Y/n]:"
	read source
	if [ $source eq Y || y ]; then
		sudo auditctl -l | egrep -i "faillock|lastlog|tallylog|sudoers"
	fi
. rollback.sh
roll
}


