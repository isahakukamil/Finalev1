#!/bin/bash

Trace() {
echo "####################################################"
echo "##----Script to Disable Trace HTTP on IN nodes----##"
echo "##----Name:Issahaku Kamil | UserID : EKAMISS------##"
echo "####################################################"
file=/etc/httpd/conf/httpd.conf
ExtrTimeStamp=$(date "+%Y-%m-%d_%H-%M-%S");
echo ""
echo "Note the Date-Time-Stamp in case of a rollback:$ExtrTimeStamp"
echo ""

echo ""
echo "Do you want to disable HTTP trace? yes/no. It is advisable to do so according to MBSS"
echo ""
read trace
trace=${trace^^}
if [[ "$trace" == "YES" ]]
then 
	echo "Disabling HTTP trace.."
	sed -i 's/TraceEnable .*/TraceEnable off/g' $file
	status="$?"
	if [[ "$status" == "0" ]]
	then
		echo "HTTP trace disabled successfully"
	elif [[ "$status" == "1" ]]
	then
		echo "Failed to disabled HTTP trace"
	else
		echo "exit status=$status"
	fi
elif [[ "$trace" == "NO" ]]
then
	echo "Aborting Operation.."
else
	echo "Wrong input!, Kindly enter either yes/no"
	Trace
fi
. rollback.sh
roll
}

