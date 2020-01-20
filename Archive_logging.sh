Archive-log(){
echo "##################################################################"
echo "##---Script to enable archive logging in Postgresql database----##"
echo "##--------------Name : Issahaku | Signum: ekamiss---------------##"
echo "##################################################################"
echo ""
echo "Would you like to enable archive logging? yes/no"
echo ""
file=/var/lib/pgsql/data/postgresql.conf
read data
data=${data^^}
if [[ "$data" == "YES" ]]
then
	echo "Enabling archive logging..."
	sed -i 's/.*wal_level.*/wal_level = archive/g' $file
	status="$?"
	if [[ "$status" == "0" ]]
	then
		echo "Archive Logging Enabled"
		systemctl restart prostgresql
		status="$?"
        	if [[ "$status" == "0" ]]
        	then
                	echo "Postgresql service restarted successfully"
       		elif [[ "$status" == "1" ]]
        	then
                	echo "Failed to restart postgresql"
        	else
                	echo "exit status=$status"
        	fi
	elif [[ "$status" == "1" ]]
	then
		echo "Failed to enable archive logging"
	else
		echo "exit status=$status"
	fi
elif [[ "$data" == "NO" ]]
then
	echo "Aborting Operation"
	echo "Operation Aborted"
else
	echo "Wrong character!, Kindly enter either yes/no"
	. rollback.sh
	roll
fi

. rollback.sh
roll
}

