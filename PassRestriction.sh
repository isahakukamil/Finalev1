#1/bin/bash

Restriction(){
echo "#################################################################"
echo "##---------Script to Set Password Restiction on IN node--------##"
echo "##-----------Name:Issahaku Kamil | UserID : EKAMISS------------##"
echo "#################################################################"

#Create a backup directory,extract and append timestamp to backup filename and copy files to new backup file

file8=/etc/login.defs
file9=/etc/security/pwquality.conf

if grep -Fxq "LoginDefsBackup" /tmp 2&>/dev/null
then
	echo ""
        echo "Backup of /etc/login.defs is stored in  /tmp/LoginDefsBackup directory..."
        echo ""

else
	mkdir /tmp/LoginDefsBackup 2&>/dev/null
	echo ""
        echo "Backup of /etc/login.defs is stored in  /tmp/LoginDefsBackup directory"
        echo ""
fi

if grep -Fxq "pamConfBackup" /tmp 2&>/dev/null
then
	echo ""
        echo "Backup of /etc/security/pwquality.conf is stored in  /tmp/pamConfBackup directory"
        echo ""

else
	mkdir /tmp/pamConfBackup 2&>/dev/null
	echo ""
        echo "Backup of /etc/security/pwquality.conf is stored in  /tmp/pamConfBackup directory"
        echo ""
fi

ExtrTimeStamp=$(date "+%Y-%m-%d_%H-%M-%S")
echo ""
echo "Note the Date-Time-Stamp in case of a rollback:$ExtrTimeStamp"
echo ""

touch /tmp/LoginDefsBackup/LoginDefsBackup.$ExtrTimeStamp;
touch /tmp/pamConfBackup/PamConfBackup.$ExtrTimeStamp;
cp -r $file8 /tmp/LoginDefsBackup/LoginDefsBackup.$ExtrTimeStamp
cp -r $file9 /tmp/pamConfBackup/PamConfBackup.$ExtrTimeStamp

#Set password restictions
echo ""
echo "This is meant to set the password restrictions on the node."
echo "Please Enter the maximum number of days a password should" 
echo "be valid until the next password change"
echo ""
read passval
echo "Do you want to set the password max days to $passval? yes/no"
read passres
passres=${passres^^}
if [[ "$passres" == "YES" ]]
then
	echo "Setting the password max days to $passval days.."
	sed -i 's/.*PASS_MAX_DAYS.*/PASS_MAX_DAYS '$passval'/g' $file8
	status="$?"
	if [[ "$status" == "0" ]]
	then
		echo ""
		echo "Duration before the next password change is set to $passval days"
		echo ""
	elif [[ "$status" == "1" ]]
	then 
        	echo "Could not set password max days to $passval days"
        	echo ""
	else
		echo "exit status=$status"
	fi
elif [[ "$passres" == "NO" ]]
then
	echo "Aborting Operation ..."
	echo "Operation Aborted"
else
	echo "Wrong input!, Please enter either yes/no"
	Restriction
fi	

#Set password warn age
echo ""
echo "This is meant to set the password change warning on the node."
echo "Please Enter the maximum number of days a password change alert"
echo "should be displayed and prompted to change password"
echo ""
read passage
echo "Do you want to set the password max days to $passage? yes/no"
read passag
passag=${passag^^}
if [[ "$passag" == "YES" ]]
then
        echo "Setting the password warn age to $passage days.."
        sed -i 's/.*PASS_WARN_AGE.*/PASS_WARN_AGE '$passage'/g' $file8
        status="$?"
        if [[ "$status" == "0" ]]
        then
                echo ""
                echo "Duration before the next password change warning is set to $passage days"
                echo ""
        elif [[ "$status" == "1" ]]
        then
                echo "Could not set password warn age to $passage days"
                echo ""
        else
                echo "exit status=$status"
        fi
elif [[ "$passag" == "NO" ]]
then
        echo "Aborting Operation ..."
	echo "Operation Aborted"
else
        echo "Wron input!, Please enter either yes/no"
	Restriction
fi

#Set password minimum days
echo ""
echo "This is meant to set the minimum password change on the node."
echo "Please Enter the minimum number of days a password should change"
echo ""
read passmin
echo "Do you want to set the password min days to $passmin? yes/no"
read passmind
passmind=${passmind^^}
if [[ "$passmind" == "YES" ]]
then
        echo "Setting the password min days to $passmin days.."
        sed -i 's/.*PASS_MIN_DAYS.*/PASS_MIN_DAYS '$passmin'/g' $file8
        status="$?"
        if [[ "$status" == "0" ]]
        then
                echo ""
                echo "minimum duration before the next password change warning is set to $passmin days"
                echo ""
        elif [[ "$status" == "1" ]]
        then
                echo "Could not set min password days to $passmin days"
                echo ""
        else
                echo "exit status=$status"
        fi
elif [[ "$passmind" == "NO" ]]
then
        echo "Aborting Operation ..."
	echo "Operation Aborted"
else
        echo "Wrong input!, Please enter either yes/no"
	Restriction
fi

#Set password minimum length
echo ""
echo "This is meant to set the minimum password length on the node. Please Enter the minimum length of password"
echo ""
read passlen
echo "Do you want to set the password min length to $passlen? yes/no"
read passleng
passleng=${passleng^^}
if [[ "$passleng" == "YES" ]]
then
        echo "Setting the password min length to $passlen.."
        sed -i 's/.*PASS_MIN_LEN.*/PASS_MIN_LEN '$passlen'/g' $file8
        status="$?"
        if [[ "$status" == "0" ]]
        then
                echo ""
                echo "minimum length for password is set to $passlen days"
                echo ""
        elif [[ "$status" == "1" ]]
        then
                echo "Could not set min password length to $passlen days"
                echo ""
        else
                echo "exit status=$status"
        fi
elif [[ "$passleng" == "NO" ]]
then
        echo "Aborting Operation ..."
	echo "Operation Aborted"
else
        echo "Wrong input!, Please enter either yes/no"
	Restriction
fi

#Set minimum number of characters that can be different from old password
echo ""
echo "This is meant to set the minimum characters that can be different from the old password on the node. Please Enter the minimum number of characters"
echo ""
read mincharval
echo "Do you want to set the difok value to $mincharval characters? yes/no"
read minchar
minchar=${minchar^^}
if [[ "$minchar" == "YES" ]]
then
	echo "setting the min characters that can be different to $mincharval"
	sed -i -e 's/.* difok .*/difok = '$mincharval'/g;' $file9
	status="$?"
	if [[ "$status" == "0" ]]
	then
        	echo ""
        	echo "The minimum number of characters that must be different from old password is set to $mincharval"
        	echo ""
	elif [[ "$status" == "1" ]]
	then
        	echo ""
        	echo "..........Could not set min char to $mincharval.........."        	
	else
        	echo "exit status=$status"
	fi
elif [[ "$minchar" == "NO" ]]
then
	echo "Aborting Operation.."
	echo "Operation Aborted"
else
	echo "Wrong input!, Please enter either yes/no"
	Restriction
fi


#Set minimum number of special characters that can be used to set a new  password
echo ""
echo "This is meant to set the minimum number of special characters that can be used to set a new  password on the node. Please Enter the minimum number special of characters required"
echo ""
read minspecval
echo "Do you want to set the ocredit value to $minspecval characters? yes/no"
read minspec
minspec=${minspec^^}
if [[ "$minspec" == "YES" ]]
then
        echo "setting the min special characters to $minspecval"
        sed -i -e 's/.* ocredit .*/ocredit = '$minspecval'/g;' $file9
        status="$?"
        if [[ "$status" == "0" ]]
        then
                echo ""
                echo "The minimum number of special characters is set to $minspecval"
                echo ""
        elif [[ "$status" == "1" ]]
        then
                echo ""
                echo "Could not set min spec char to $minspecval"
        else
                echo "exit status=$status"
        fi
elif [[ "$minspec" == "NO" ]]
then
        echo "Aborting Operation.."
	echo "Operation Aborted"
else
        echo "Wrong input!, Please enter either yes/no"
	Restriction
fi

#Set minimum number of required digits that can be used in setting a new password
echo ""
echo "This is meant to set the minimum of required digits used to set a new password on the node. Please Enter the minimum number of digits required"
echo ""
read mindigval
echo "Do you want to set the  value to $mindigval digits? yes/no"
read mindig
mindig=${mindig^^}
if [[ "$mindig" == "YES" ]]
then
        echo "setting the min number of digits to $mindigval"
        sed -i -e 's/.* dcredit .*/dcredit = '$mindigval'/g;' $file9
        status="$?"
        if [[ "$status" == "0" ]]
        then
                echo ""
                echo "The minimum number of digits is set to $mindigval"
                echo ""
        elif [[ "$status" == "1" ]]
        then
                echo ""
                echo "..........Could not set min number of digits to $mindigval.........."
        else
                echo "exit status=$status"
        fi
elif [[ "$mindig" == "NO" ]]
then
        echo "Aborting Operation.."
	echo "Operation Aborted"
else
        echo "Wrong input!, Please enter either yes/no"
	Restriction
fi

#Set the number of upper-case characters that can be used in setting a new password
echo ""
echo "This is meant to set the minimum of upper-case characters used to set a new password on the node. Please Enter the minimum number of upper-case characters required"
echo ""
read minupval
echo "Do you want to set the number of upper-case char to $minupval? yes/no"
read minup
minup=${minup^^}
if [[ "$minup" == "YES" ]]
then
        echo "setting the number of upper-case chars to $minupval"
        sed -i -e 's/.* ucredit .*/ucredit = '$minupval'/g;' $file9
        status="$?"
        if [[ "$status" == "0" ]]
        then
                echo ""
                echo "The minimum number of upper-case char is set to $minupval"
                echo ""
        elif [[ "$status" == "1" ]]
        then
                echo ""
                echo "..........Could not set number of upper-case to $minupval.........."
                echo ""
        else
                echo "exit status=$status"
        fi
elif [[ "$minup" == "NO" ]]
then
        echo "Aborting Operation.."
	echo "Operation Aborted"
else
        echo "Wrong input, Please enter either yes/no"
	Restriction
fi


#Set number of lower-case characters that can be used in setting a new password
echo ""
echo "This is meant to set the number of required characters used to set a new password on the node. Please Enter the number oflower-case characters required"
echo ""
read minlowval
echo "Do you want to set the  value to $minlowval digits? yes/no"
read minlow
minlow=${minlow^^}
if [[ "$minlow" == "YES" ]]
then
        echo "setting the number of lower-case char to $minlowval"
        sed -i -e 's/.* lcredit .*/lcredit = '$minlowval'/g;' $file9
        status="$?"
        if [[ "$status" == "0" ]]
        then
                echo ""
                echo "The number of lowercase char is set to $minlowval"
                echo ""
        elif [[ "$status" == "1" ]]
        then
                echo ""
                echo "Could not set number of lowercase to $minlowval"
        else
                echo "exit status=$status"
        fi
elif [[ "$minlow" == "NO" ]]
then
        echo "Aborting Operation.."
	echo "Operation Aborted"
else
        echo "Wrong input, Please enter either yes/no"
	Restriction
fi

. rollback.sh
roll
}

