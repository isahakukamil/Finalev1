#!/bin/bash

#---MOP WORK PACKAGE TAG: WP039V3---
#---DESC:
#---RESTRICT ACCESS OF AUDIT LOGS---

#---SCRIPT BY REUBEN A. BOAKYE---
#---SIGNUM: EBOAREU---

#---All scripts run are logged into a single log file called "script.log"
#with file path /var/log/script.log---

AuditLog_Restrict () {
	file1=/var/log/audit/audit.log
	file2=/var/log/faillog
	file3=/var/log/postgresql

	#Change permission for "file1"
	if test -f "$file1"; then
		timeStamp=$(date '+%m_%y_%H_%M_%S')
		fExtension=".log"
		backupFile=/var/log/audit/$timeStamp$fExtension
		logName="script"
		logFile=/var/log/$logName$fExtension

	#This creates a backup of the configuration file.
		sudo cp $file1 $backupFile

		sudo chmod go-rw $file1
		STATUS= echo "$?"

	#This tests if logfile is already created.
		if test -f "$logFile"; then 
			if [ $STATUS -eq 0 ]; then
				echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
				sudo systemctl restart auditd
			else
				echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
				mv $backupfile $file1
			fi
		else
			sudo touch $logFile
			if [ $STATUS -eq 0 ]; then
				echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
				sudo systemctl restart auditd
			else
				echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
				sudo mv $backupfile $file1
			fi
		fi
	else 
		echo "***THE CONFIGURATION FILE DOES NOT EXIST!***"
	fi

	#Change permission for file2
	if test -f "$file2"; then
		timeStamp=$(date '+%m_%y_%H_%M_%S')
		fExtension="log"
		backupFile=/var/log/$timeStamp
		logName="script"
		logFile=/var/log/$logName$fExtension

	#This creates a backup of the configuration file.
		sudo cp $file2 $backupFile

		sudo chmod go-rw $file2
		STATUS= echo "$?"
		if [ $STATUS -eq 0 ]; then
			echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
		else
			echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
			mv $backupfile $file2
		fi
	else 
		echo "***THE CONFIGURATION FILE DOES NOT EXIST!***"
	fi

	#Change permission for file3
	if test -f "$file3"; then
		timeStamp=$(date '+%m_%y_%H_%M_%S')
		fExtension="log"
		backupFile=/var/log/$timeStamp
		logName="script"
		logFile=/var/log/$logName$fExtension

	#This creates a backup of the configuration file.
		sudo cp $file2 $backupFile

		sudo chmod go-rw $file3
		STATUS= echo "$?"
		if [ $STATUS -eq 0 ]; then
			echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
		else
			echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
			mv $backupfile $file3
		fi
	else 
		echo "***THE CONFIGURATION FILE DOES NOT EXIST!***"
	fi
. rollback.sh
roll
}



