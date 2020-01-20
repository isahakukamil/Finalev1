#!/bin/bash

#---MOP WORK PACKAGE TAG: WP052V3---
#---DESC:
#THIS SCRIPT PROVIDES SCREENSHOT FOR SECURITY CONTROL VALIDATION---

#---SCRIPT BY REUBEN A BOAKYE
#SIGNUM: EBOAREU---


#---CHECK IF GNOME-SCREENSHOT PACKAGE IS INSTALLED---
#---THIS IS THE PACKAGE NEEDED FOR THE SCREENSHOT TO BE TAKEN---

Security_Control () {
	filename="gnome-screenshot" 
	if rpm -qa | grep -i $filename
	then
		echo "`tput bold`Package is already installed"
	else 
		echo "`tput bold`Package not installed. Proceeding to install..."	
		sudo yum -y install $filename
	fi    

	#---/VAR/LOG FILES---

	ls -l /var/log/secure
	ls -l /var/log/audit/audit.log
	ls -l /var/log/messages
	ls -l /var/log/lastlog
	ls -l /var/run/faillock

	echo "Please enter file name"
	read name
	imgExtension=".png"
	imgName=$name$imgExtension
	gnome-screenshot -w --file="$imgName"

	#---CAT AND MORE---

	cat /etc/ssh/sshd_config | grep -i PermitRootLogin
	crontab -l
	more /etc/issue
	more /etc/motd
	more /etc/ftpd/banner.msg
	cat /etc/sudoers
	cat /etc/group
	cat /etc/passwd

	echo "Please enter new file name"
	read name
	imgExtension=".png"
	imgName=$name$imgExtension
	gnome-screenshot -w --file="$imgName"

. rollback.sh
roll
}





