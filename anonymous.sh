#!/bin/bash

anonym(){
echo "#################################################################"
echo "##-----Script to Disable Anonymous Login via FTP on IN nodes---##"
echo "##-------------Name:Issahaku Kamil | UserID : EKAMISS----------##"
echo "#################################################################"

file1=/etc/vsftpd/vsftpd.conf

#Disable Anonymous login on FTP
echo ""
echo "Do you want to Enable Anonymous FTP? YES/NO"
echo ""
read anon
anon=${anon^^}
if [[ "$anon" == "YES" ]]
then
        sed -i 's/.* anonymous_enable .*/anonymous_enable='$anon'/g' $file1
        status="$?"
        if [[ "$status" == "0" ]]
        then
                echo ""
                echo "Anonymous FTP has been enabled successfully"
                echo ""
		
		#Restart ftp service
		systemctl restart vsftpd
		status="$?"
		if [[ "$status" == "0" ]]
		then
        		echo ""
        		echo "VSFTPD has been Restarted Successfully"
        		echo ""
		elif [[ "$status" == "1" ]]
		then
        		#Rollback if the action is not successful
        		echo ""
        		echo "<<<<<<<<<<<<Failed to Restart VSFTPD..Trying again>>>>>>>>>"
        		echo ""
		else
        		echo ""
        		echo "exit status=$status"
        		echo ""
		fi
        elif [[ "$status" == "1" ]]
        then
                echo ""
                echo "Failed to enable anonymous FTP"
                echo ""
        else
                echo "exit status=$status"
        fi
elif [[ "$anon" == "NO" ]]
then
        sed -i 's/.* anonymous_enable .*/anonymous_enable='$anon'/g' $file1
        status="$?"
        if [[ "$status" == "0" ]]
        then
                echo ""
                echo "Anonymous FTP has been disabled successfully"
                echo ""
        elif [[ "$status" == "1" ]]
        then
                echo ""
                echo "Failed to disable anonymous FTP"
                echo ""
        else
                echo "exit status=$status"
        fi
else
	echo ""
	echo "Wrong character!, Kindly enter eithr yes/no"
	echo ""
	. rollback.sh
	roll
fi

. rollback.sh
roll
}
