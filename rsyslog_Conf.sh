#!/bin/bash

#---MOP WORK PACKAGE TAG: WP040V3---
#---DESC:
#---CONFIGURING REMOTE SYSLOG FROM UNIX/LINUX SERVER---

#---SCRIPT BY REUBEN A. BOAKYE---
#---SIGNUM: EBOAREU---

#---All scripts run are logged into a single log file called "script.log"
#with file path /var/log/script.log---

rsyslog () {
	file=/etc/rsyslog.conf
	fileNew=/etc/audisp/plugins.d/syslog.conf

	#Set up remote logging
	if test -f "$file"; then
		timeStamp=$(date '+%m_%y_%H_%M_%S')
		fExtension=".conf"
		fExtension1=".log"
		backupFile=/etc/$timeStamp$fExtension
		logName="script"
		logFile=/var/log/$logName$fExtension1

	#This creates a backup of the configuration file.
		sudo cp $file $backupFile

		echo "PLEASE ENTER THE REMOTE SERVER IP:"
		read source

		sed -i "s/*.*/*.* @$source:514/g"  $file
		STATUS=`echo "$?"`

	#This tests if logfile is already created.
		if test -f "$logFile"; then 
			if [ $STATUS -eq 0 ]; then
				echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
				sudo service rsyslog restart
			else
				echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
				mv $backupfile $file
			fi
		else
			sudo touch $logFile
			if [ $STATUS -eq 0 ]; then
				echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
				sudo service rsyslog restart
			else
				echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
				sudo mv $backupfile $file
			fi
		fi
	else 
		echo "***THE CONFIGURATION FILE DOES NOT EXIST!***"
	fi

	#Enable remote audit logging.
	if test -f "$fileNew"; then
		timeStamp=$(date '+%m_%y_%H_%M_%S')
		fExtension=".conf"
		fExtension1=".log"
		backupFile=/etc/audisp/plugins.d/$timeStamp$fExtension
		logFile=/etc/audisp/plugins.d/script.log

	#This creats a backup of the configuration file.
		sudo cp $fileNew $backupFile	

		sed -i "s/active/active = yes/g" $fileNew
		sed -i "s/direction/direction = out/g" $fileNew
		sed -i "s/path/path = builtin_syslog/g" $fileNew
		sed -i "s/type/type = builtin/g" $fileNew
		sed -i "s/args/args = LOG_INFO/g" $fileNew
		sed -i "s/format/format = string/g" $fileNew

		STATUS=`echo "$?"`
		if [ $STATUS -eq 0 ]; then
			echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
		else
			echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
			sudo mv $backupfile $fileNew
		fi
	else 
		echo "***THE CONFIGURATION FILE DOES NOT EXIST!***"
	fi
. rollback.sh
roll
}

