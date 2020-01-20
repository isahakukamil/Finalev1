#!/bin/bash

Change_Acc_Password() {
echo ""
echo "############################################################################"
echo "##------Script to Change Default System Account Password on IN nodes------##"
echo "##------------------Name:Issahaku Kamil | UserID : EKAMISS----------------##"
echo "############################################################################"
echo ""
echo "You must be root before doing this."
echo "Kindly Enter the System Account and New Password in this format"
echo "for example, username:password. In order to change to default password"
echo "for a particular system account"
echo "Kindly press ctrl+D once you are done entering usernames and passwords"
echo ""
chpasswd;

. rollback.sh
roll
} 

