#!/bin/bash

SSL-Pro() {
echo "############################################################"
echo "##-----Script to Disable Weak SSL Protocols on IN nodes---##"
echo "##-------Name:Issahaku Kamil | UserID : EKAMISS-----------##"
echo "############################################################"

ExtrTimeStamp=$(date "+%Y-%m-%d_%H-%M-%S");
echo ""
echo "Note the Date-Time-Stamp in case of a rollback:$ExtrTimeStamp"
echo ""

if grep -Fxq "SSLConfigBack" /tmp 2&>/dev/null
then
        echo "The backup of /etc/httpd/conf.d/ssl.conf is stored in /tmp/SSLConfigBack directory"
        echo ""

else
        mkdir /tmp/SSLConfigBack/ 2&>/dev/null
        echo ""
fi

echo "Creating a backup of the /etc/httpd/conf.d/ssl.conf directory with timestamp $ExtrTimeStamp"
touch /tmp/SSLConfigBack/SSLConfigBackup.$ExtrTimeStamp;
cp -r /etc/httpd/conf.d/ssl.conf /tmp/SSLConfigBack/SSLConfigBackup.$ExtrTimeStamp;
echo "Backup is called: /tmp/SSLConfigBack/SSLConfigBackup.$ExtrTimeStamp"

echo ""
echo "Do you want to Disable Weal SSL/TLS Protocol versions? yes/no"
echo ""
read wek
wek=${wek^^}
if [[ "$wek" == "YES" ]]
then
	echo "Disabling Weak SSL/TLS Protocols..."
	sed -i 's/.*SSLProtocol.*/SSLProtocol all -SSLv2 -SSLv3 -TLSv1/g' /etc/httpd/conf.d/ssl.conf
	status="$?"
	if [[ "$status" == "0" ]]
	then
		echo "Weak SSL/TLS Protocls have been disabled.."	
		systemctl restart httpd
		status="$?"
		if [[ "$status" == "0" ]]
		then
        		echo ""
       			echo "Web server has been Restarted Successfully"
        		echo ""
		elif [[ "$status" = "1" ]]
		then
        		echo ""
        		echo "<<<<<<<<<<<<Failed to Restart Web Server..Trying again>>>>>>>>>"
        		echo ""
		else
        		echo ""
        		echo "exit status=$status"
        		echo ""
		fi
	elif [[ "$status" == "1" ]]
	then
		echo "Could disable weak SSL protocols"
	else
		echo "exit status=$status"
	fi

elif [[ "$wek" == "NO" ]]
then
	echo "Aborting Operation..."
	echo "Operation Aborted"
else
	echo "Wrong Input!, Please enter either yes/no"
	. rollback.sh
	roll
fi
. rollback.sh
roll

}

