#!/bin/bash

Weak_Snmp() {
echo "####################################################"
echo "##----Script to Disable WeaK SNMP on IN nodes-----##"
echo "##-----Name:Issahaku Kamil | UserID : EKAMISS-----##"
echo "####################################################"

#Create a backup directory,extract and append timestamp to backup filename and copy files to new backup file

file=/etc/snmp/snmpd.conf
if grep -Fxq "SNMPConfigBack" /tmp 2&>/dev/null
then
	echo ""
	echo "The backup of /etc/snmp/snmpd_config is stored in /tmp/SNMPConfigBack directory...."
	echo ""
else
	mkdir /tmp/SNMPConfigBack/ 2&>/dev/null
fi

ExtrTimeStamp=$(date "+%Y-%m-%d_%H-%M-%S");
echo ""
echo "Note the Date-Time-Stamp in case of a rollback:$ExtrTimeStamp"
echo ""

touch /tmp/SNMPConfigBack/SNMPConfigBackup.$ExtrTimeStamp;
cp -r $file /tmp/SNMPConfigBack/SNMPConfigBackup.$ExtrTimeStamp;

sed -s "s/rocommunity.*/rocommunity ESA-PC 127.0.0.1/g" $file
status="$?"
if [[ "$status" == "0" ]]
then
	echo "Strong string has been set in rocommunity string"
elif [[ "$status" == "1" ]]
then
	echo "Failed to set strong SNMP string"
else
	echo "exit status=$status"
fi


sed -s "s/rwcommunity.*/rocommunity ESA-PE 127.0.0.1/g" $file
status="$?"
if [[ "$status" == "0" ]]
then
	echo "Strong string has been set in rwcommunity string"
elif [[ "$status" == "1" ]]
then
	echo "Failed to set strong SNMP string"
else
	echo "exit status=$status"
fi

sed -s "s/com2sec.*/ /g" $file
status="$?"
if [[ "$status" == "0" ]]
then
	echo "SNMP v1 and v2 have been deleted"
elif [[ "$status" == "1" ]]
then
	echo "Failed to remove weak snmp versions"
else
	echo "exit status=$status"
fi

. rollback.sh
roll
} 

