#!/bin/bash

#---MOP WORK PACKAGE TAG: WP035V3---
#---DESC:
#---ENABLE AUDIT LOGGING---

#---SCRIPT BY REUBEN A. BOAKYE---
#---SIGNUM: EBOAREU---


#---All scripts run are logged into a single log file called "script.log"
#with file path /var/log/script.log---

auditlog1 () {

		timeStamp=$(date '+%m_%y_%H_%M_%S')
		fExtension1=".log"
		logName="script"
		logFile=/var/log/$logName$fExtension1

	#This command will output the status of audit logging, whether enabled or not.
		sudo auditctl -s
		sudo autditctl -e 1

		STATUS=`echo "$?"`

	#This tests if logfile is already created.
		if test -f "$logFile"; then 
			if [ $STATUS -eq 0 ]; then
				echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
				systemctl restart auditd
			else
				echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
			fi
		else
			sudo touch $logFile
			if [ $STATUS -eq 0 ]; then
				echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
				systemctl restart auditd
			else
				echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
			fi
		fi
		
		
		
	#This command lists all loaded audit rules.
		echo "########## PLEASE VERIFY THE FOLLOWING AUDIT RULES #########"
		sudo auditctl -l
		
		STATUS=`echo "$?"`
		
		if [ $STATUS -eq 0 ]; then
			echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
		else
			echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
		fi

. rollback.sh
roll
}


	
