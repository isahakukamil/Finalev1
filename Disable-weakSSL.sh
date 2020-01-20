#!/bin/bash

Weak_SSL() {
echo "##########################################################"
echo "##-----Script to Disable Weak SSL Cipher on IN nodes----##"
echo "##--------Name:Issahaku Kamil | UserID : EKAMISS--------##"
echo "##########################################################"

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
echo "Do you want to Disable Weal SSL Ciphers? yes/no"
echo ""
read wik
wik=${wik^^}
if [[ "$wik" == "YES" ]]
then
	echo "Disabling Weak SSL Ciphers..."
	sed -i 's/.*SSLHonorCipherOrder.*/SSLHonorCipherOrder on/g' /etc/httpd/conf.d/ssl.conf
	status="$?"
	if [[ "$status" == "0" ]]
	then
		echo "SSL Cipher Order has been turned on.."
	elif [[ "$status" == "1" ]]
	then
		echo "Could not turn on SSL Cipher order"
	else
		echo "exit status=$status"
	fi

        sed -i 's/.*SSLCipherSuite.*/SSLCipherSuite HIGH:!MEDIUM:!NULL:!MD5/g' /etc/httpd/conf.d/ssl.conf
        status="$?"
        if [[ "$status" == "0" ]]
        then
                echo "SSL Cipher Suite Specified.."
        elif [[ "$status" == "1" ]]
        then
                echo "Could not set SSL Cipher Suite"
        else
                echo "exit status=$status"
        fi
	systemctl restart httpd
	status="$?"
	if [[ "$status" == "0" ]]
	then
        	echo ""
       		echo "Web server has been Restarted Successfully"
        	echo ""
	elif [[ "$status" = "1" ]]
	then
        	#Rollback if the action is not successful
        	echo ""
        	echo "<<<<<<<<<<<<Failed to Restart Web Server..Trying again>>>>>>>>>"
        	echo ""
	else
        	echo ""
        	echo "exit status=$status"
        	echo ""
	fi
elif [[ "$wik" == "NO" ]]
then
	echo "Aborting Operation..."
	echo "Operation Aborted"
else
	echo "Wrong input!, Please enter either yes/no"
	. rollback.sh
	roll
fi

. rollback.sh
roll

}

