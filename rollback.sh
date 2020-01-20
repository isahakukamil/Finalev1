
roll(){
echo ""
echo "Do you want to perform another operation? yes/no"
echo ""
read ops
ops=${ops^^}
if [[ "$ops" == "YES" ]]
then
	. MtnSecurity.sh
	Master
elif [[ "$ops" == "NO" ]]
then
	echo "Aborting Operation.."
	echo "Operation Aborted"
else
	echo "Wrong input!,Kindly enter Either yes/no to continue"
	. rollback.sh
	roll
fi
}
