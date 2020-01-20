DB(){
echo "#########################################################################"
echo "##-----Script to Prevent direct login to the database over network-----##"
echo "##---------------Name : Issahaku | Signum: ekamiss---------------------##"
echo "#########################################################################"
echo ""
echo "Would you like to prevent direct login to the database."
echo "This poses a security concern and its advisable to prevent that"
echo ""
file=/var/lib/pgsql/data/pg_hba.conf
read data
data=${data^^}
if [[ "$data" == "YES" ]]
then
	echo "Disabling..."
	sed -i 's/.*local.*/local all all md5/g' $file
	status="$?"
	if [[ "$status" == "0" ]]
	then
		echo "Direct access to database disabled"
		systemctl restart prostgresql
		status="$?"
        	if [[ "$status" == "0" ]]
        	then
                	echo "Postgresql service restarted successfully"
       		elif [[ "$status" == "1" ]]
        	then
                	echo "Failed to restart postgresql"
			break
        	else
                	echo "exit status=$status"
        	fi
	elif [[ "$status" == "1" ]]
	then
		echo "Failed to disable direct access to DB"
	else
		echo "exit status=$status"
	fi
	sed -i 's/.*host.*/host all all 127.0.0.1\/32 md5/g' $file
	status="$?"
	if [[ "$status" == "0" ]]
	then
		echo "Direct access to database disabled"
		systemctl restart prostgresql
		status="$?"
        	if [[ "$status" == "0" ]]
        	then
                	echo "Postgresql service restarted successfully"
       		elif [[ "$status" == "1" ]]
        	then
                	echo "Failed to restart postgresql"
			break
        	else
                	echo "exit status=$status"
        	fi

	elif [[ "$status" == "1" ]]
	then
		echo "Failed to disable direct access to DB"
	else
		echo "exit status=$status"
	fi
elif [[ "$data" == "NO" ]]
then
	echo "Aborting Operation"
	echo "Operation Aborted"
else
	echo "exit status=$status"
fi

. rollback.sh
roll
}

