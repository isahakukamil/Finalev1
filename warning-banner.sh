#!/bin/bash
Warning() {
echo "##################################################################"
echo "##-----Script to Create & Enable Warning Banners on IN nodes----##"
echo "##-----------Name:Issahaku Kamil | UserID : EKAMISS-------------##"
echo "##################################################################"

ExtrTimeStamp=$(date "+%Y-%m-%d_%H-%M-%S");
echo ""
echo "Note the Date-Time-Stamp in case of a rollback:$ExtrTimeStamp"
echo ""

echo ""
echo "Do you want to set the Login warning banners? yes/no"
echo ""
read warn
warn=${warn^^}
if [[ "$warn" == "YES" ]]
then
	echo "Please type out the banner mesage to display before the password login prompt.."
	echo "Kindly press ctrl + D to save typed warning banner"
	cat > /etc/issue.net
	echo "Your login warning banner has been set to :"
	cat /etc/issue.net
	if grep -Fxq "banner /etc/issue.net" /etc/ssh/sshd_config
	then
		echo "Banner set successfully for SSH logins"
	else
		echo "banner /etc/issue.net" >> /etc/ssh/sshd_config
		echo "Banner set successfully for SSH logins"
	fi
	
	if grep -Fxq "banner_file=/etc/issue.net" /etc/vsftpd/vsftpd.conf
        then
                echo "Banner set successfully for FTP logins"
        else
                echo "banner_file /etc/issue.net" >> /etc/vsftpd/vsftpd.conf
                echo "Banner set successfully for FTP logins"
        fi
	

	
	echo "Please type out the banner message to display before the user has logs in.."
        echo "Kindly press ctrl + D to save typed warning banner"
        cat > /etc/motd
        echo "Your motd banner has been set to :"
        cat /etc/motd
elif [[ "$warn" == "NO" ]]
then
	echo "Aborting Operation"
else
	echo "exit status=$status"
fi
. rollback.sh
roll
}

