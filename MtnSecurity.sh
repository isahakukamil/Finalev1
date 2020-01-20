#!/bin/bash
Master (){
echo ""
echo "####################################################################"
echo "##--This script is meant to automate the check compliance level---##"
echo "##--with regards to the MTN security baseline compliance as well--##"
echo "##--as set security configurations where necessary. This script---##"
echo "##--displays a timestamp at the beginning of every operation to---##"
echo "##--give an idea as to where backups and logs as and when there---##"
echo "##--is the need for a rollback. Actions of the script are logged--##"
echo "##--for the purpose of tracing errors asssociated with scripts.---##"
echo "####################################################################"
echo ""
echo "Please enter the number corresponding to the node you would like"
echo "to run scripts on(1-9). NB:You can Enter 0 to exit the nodes list"
echo ""
echo "1. SDP"
echo ""
echo "2. OCC"
echo ""
echo "3. AIR"
echo ""
echo "4. EMM"
echo ""
echo "5. ECMS"
echo ""
echo "6. NG-VS"
echo ""
echo "7. CCN"
echo ""
echo "8. EMA/EDA"
echo ""
echo "9. NG-CRS"
echo ""
echo "0. Exit"
echo ""
read nod

case $nod in 
	1)
		echo ""
		echo "The following scripts show the various security baselines compliance configurations on SDP. "
		echo "Please Enter the number between 1-29 associated with the appropriate script to run or enter "
		echo "29 to run all the scripts corresponding to the MBSS compliance list required by MTN"
		echo "You can enter 0 to exit the scripts for SDP"
		echo ""
		echo "1. Restrict Root Access on SDP node"
		echo "2. Disallow root access via FTP on SDP node"
		echo "3. Set Account Lockout Threshold for invalid logon attempts on SDP node"
		echo "4. Restrict mounting of NFS shares on SDP node"
		echo "5. Restrict concurrent unauthenticated user access from different terminals on SDP node"
		echo "6. Use of SSH key based authentication on SDP node"
		echo "7. Remove or disable inactive users on SDP node"
		echo "8. set Password restriction, Complexity and Expiry on SDP node"
		echo "9. Disable insecure and unused services on SDP node"
		echo "10. Configure SSH Session Timeout on SDP node"
		echo "11. Disable Anonymous FTP login on SDP node"
		echo "12. Set X11 Protocol Forwarding on SDP node"
		echo "13. Enable Stack protection against buffer overflows on SDP node"
		echo "14. Disable/Remove CGI scripts on SDP node"
		echo "15. Create and enable warning banners on SDP node"
		echo "16. Disable Trace/Track in apache HTTPD on SDP node"
		echo "17. Disable SSL weak cipher(using RC4) in apache on SDP node"
		echo "18. Disable SSl Weak Protocols on SDP node"
		echo "19. Upgrade a supported version of apache HTTP server on SDP node"
		echo "20. Disable SSH Weak CBC Mode Ciphers on SDP node"
		echo "21. Configure remote syslog from UNIX server on SDP node"
		echo "22. Logging of user activities on OS level on SDP node"
		echo "23. Restrict access of audit logs on SDP node"
		echo "24. Provide screenshot for security control validation on SDP node"
		echo "25. Configure the host based firewall on SDP node"
		echo "26. SMTP and web server version shall not be disclosed on SDP node"
		echo "27. Change Default System Account Password"
		echo "28. Enable Audit Logging on SDP node"
		echo "29. Disable/Configure Weak SNMP Community String"
		echo "30. Run All Scripts on SDP node"
		echo "0.  Exit "
		echo ""
		echo "##############################################################################################################################"
		echo "# Please Enter the number corresponding with the checklist to execute scripts or enter 30 to run all scripts on the SDP node #"
		echo "# ----------------------------------------You can equally enter 0 to exit from SDP scripts.----------------------------------#"
		echo "##############################################################################################################################"
		echo ""
		read scrnim
		echo $scrnim

		case $scrnim in
			1)
				. Disable_root.sh
				disable_root
				;;
			2)
				. vsftpd_disable.sh
				Disable
				;;
			3)
				. Lockout_timer.sh
				Lock
				;;
			4)
				. nfs-shares.sh
				nfs-shares
				;;
			5)
				. Con-Unauth.sh
				Conc
				;;
			6) 
				. SSHkey-Auth.sh
				keyb
				;;
			7)
				. Disable_inactive.sh
				Disable_inactive
				;;
			8)
				. PassRestriction.sh
				Restriction
				;;
			9)
				. Disable_Unused_Services.sh
				Services
				;;
			10)	
				. Timeout.sh
				ssht
				;;
			11)
				. anonymous.sh
				anonym
				;;
			12)     
				. X11forwarding.sh
				X11
				;;
			13)
				. Stack-Prot.sh
				Stack
				;;
			14)
				. Remove-cgi.sh
				Remove-cgi
				;; 
			15)
				. warning-banner.sh
				Warning
				;;
			16)	
				. Trace-httpd.sh
				Trace
				;;
			17)
				. Disable-weakSSL.sh
				Weak_SSL 
				;;
			18)
				. Disable-weakPro.sh
				SSL-Pro
				;;
			19)
				. Upgrade-http.sh
				Upgrade-http
				;;
			20)
				. Disable-weakCBC.sh
				Disable_Weak_CBC
				;;
			21)
				. rsyslog_Conf.sh
				rsyslog
				;;
			22)
				. Log_user.sh
				user_log
				;;
			23)
				. Restrict_AuditLogAccess.sh
				AuditLog_Restrict
				;;
			24)
				. Sec_Control_Validation.sh
				Security-Control
				;;
			25)
				. Configure_Firewall.sh
				firewalld
				;;
			26)
				. smtp_version.sh
				SMTP_Disclosure
				;;
			27)
				. Password_Change.sh
				Change_Acc_Password
				;;
			28)
				. Enable_Logging.sh
				auditlog1
				;;
			29)
				. Configure_Weak_Snmp.sh
				Weak_Snmp
				;;
			0)	. rollback.sh
				roll
				;;
			*)
				. Try-Again.sh
				Try
				. rollback.sh
				roll
				;;
			esac;;
	2)
		echo ""
		echo "The following scripts show the various security baselines compliance configurations on OCC. "
		echo "Please Enter the number between 1-29 associated with the appropriate script to run or enter "
		echo "29 to run all the scripts corresponding to the MBSS compliance list required by MTN"
		echo "You can enter 0 to exit the scripts for OCC"
		echo ""
		echo "1. Restrict Root Access on OCC"
		echo "2. Disallow root access via FTP on OCC"
		echo "3. Set Account Lockout Threshold for invalid logon attempts on OCC"
		echo "4. Restrict mounting of NFS shares on OCC"
		echo "5. Restrict concurrent unauthenticated user access from different terminals on OCC"
		echo "6. Use of SSH key based authentication on OCC"
		echo "7. Remove or disable inactive users on OCC"
		echo "8. set Password restriction, Complexity and Expiry on OCC"
		echo "9. Disable insecure and unused services on OCC"
		echo "10. Configure SSH Session Timeout on OCC"
		echo "11. Disable Anonymous FTP login on OCC"
		echo "12. Set X11 Protocol Forwarding on OCC"
		echo "13. Enable Stack protection against buffer overflows on OCC"
		echo "14. Disable/Remove CGI scripts on OCC"
		echo "15. Create and enable warning banners on OCC"
		echo "16. Disable Trace/Track in apache HTTPD on OCC"
		echo "17. Disable SSL weak cipher(using RC4) in apache on OCC"
		echo "18. Disable SSl Weak Protocols on OCC"
		echo "19. Upgrade a supported version of apache HTTP server on OCC"
		echo "20. Disable SSH Weak CBC Mode Ciphers on OCC"
		echo "21. Configure remote syslog from UNIX server on OCC"
		echo "22. Logging of user activities on OS level on OCC"
		echo "23. Restrict access of audit logs on OCC"
		echo "24. Provide screenshot for security control validation on OCC"
		echo "25. Configure the host based firewall on OCC"
		echo "26. SMTP and web server version shall not be disclosed on OCC"
		echo "27. Change Default System Account Password"
		echo "28. Enable Audit Logging on OCC"
		echo "29. Disable/Configure Weak SNMP Community String"
		echo "30. Prevent Direct Login to the database(Postgresql)"
		echo "31. Enable Archive Logging"
		echo "0.  Exit "
		echo ""
		echo "######################################################################################"
		echo "# Please Enter the number corresponding with the checklist to execute scripts on OCC #"
		echo "#----------------You can equally enter 0 to exit from OCC scripts------------------- #"
		echo "######################################################################################"
		read scrnim
		echo $scrnim

		case $scrnim in
			1)
				. Disable_root.sh
				disable_root
				;;
			2)
				. vsftpd_disable.sh
				Disable
				;;
			3)
				. Lockout_timer.sh
				Lock
				;;
			4)
				. nfs-shares.sh
				nfs-shares
				;;
			5)
				. Con-Unauth.sh
				Conc
				;;
			6) 
				. SSHkey-Auth.sh
				keyb
				;;
			7)
				. Disable_inactive.sh
				Disable_inactive
				;;
			8)
				. PassRestriction.sh
				Restriction
				;;
			9)
				. Disable_Unused_Services.sh
				Services
				;;
			10)	
				. Timeout.sh
				ssht
				;;
			11)
				. anonymous.sh
				anonym
				;;
			12)     
				. X11forwarding.sh
				X11
				;;
			13)
				. Stack-Prot.sh
				Stack
				;;
			14)
				. Remove-cgi.sh
				Remove-cgi
				;; 
			15)
				. warning-banner.sh
				Warning
				;;
			16)	
				. Trace-httpd.sh
				Trace
				;;
			17)
				. Disable-weakSSL.sh
				Weak_SSL 
				;;
			18)
				. Disable-weakPro.sh
				SSL-Pro
				;;
			19)
				. Upgrade-http.sh
				Upgrade-http
				;;
			20)
				. Disable-weakCBC.sh
				Disable_Weak_CBC
				;;
			21)
				. rsyslog_Conf.sh
				rsyslog
				;;
			22)
				. Log_user.sh
				user_log
				;;
			23)
				. Restrict_AuditLogAccess.sh
				AuditLog_Restrict
				;;
			24)
				. Sec_Control_Validation.sh
				Security-Control
				;;
			25)
				. Configure_Firewall.sh
				firewalld
				;;
			26)
				. smtp_version.sh
				SMTP_Disclosure
				;;
			27)
				. Password_Change.sh
				Change_Acc_Password
				;;
			28)
				. Enable_Logging.sh
				auditlog1
				;;
			29)
				. Configure_Weak_Snmp.sh
				Weak_Snmp
				;;
			30)
				. Disable_DB_Login.sh
				DB
				;;
			31)
				. Archive_logging.sh
				Archive-log
				;;
			0)	. rollback.sh
				roll
				;;
			*)
				. Try-Again.sh
				Try
				. rollback.sh
				roll
				;;
			esac;;
	
	3)
		echo ""
		echo "The following scripts show the various security baselines compliance configurations on AIR. "
		echo "Please Enter the number between 1-29 associated with the appropriate script to run or enter "
		echo "29 to run all the scripts corresponding to the MBSS compliance list required by MTN"
		echo "You can enter 0 to exit the scripts for AIR"
		echo ""
		echo "1. Restrict Root Access on AIR node"
		echo "2. Disallow root access via FTP on AIR node"
		echo "3. Set Account Lockout Threshold for invalid logon attempts on AIR node"
		echo "4. Restrict mounting of NFS shares on AIR node"
		echo "5. Restrict concurrent unauthenticated user access from different terminals on AIR node"
		echo "6. Use of SSH key based authentication on AIR node"
		echo "7. Remove or disable inactive users on AIR node"
		echo "8. Set Password restriction, Complexity and Expiry on AIR node"
		echo "9. Disable insecure and unused services on AIR node"
		echo "10. Configure SSH Session Timeout on AIR node"
		echo "11. Disable Anonymous FTP login on AIR node"
		echo "12. Set X11 Protocol Forwarding on AIR node"
		echo "13. Enable Stack protection against buffer overflows on AIR node"
		echo "14. Disable/Remove CGI scripts on AIR node"
		echo "15. Create and enable warning banners on AIR node"
		echo "16. Disable Trace/Track in apache HTTPD on AIR node"
		echo "17. Disable SSL weak cipher(using RC4) in apache on AIR node"
		echo "18. Disable SSl Weak Protocols on AIR node"
		echo "19. Upgrade a supported version of apache HTTP server on AIR node"
		echo "20. Disable SSH Weak CBC Mode Ciphers on AIR node"
		echo "21. Configure remote syslog from UNIX server on AIR node"
		echo "22. Logging of user activities on OS level on AIR node"
		echo "23. Restrict access of audit logs on AIR node"
		echo "24. Provide screenshot for security control validation on AIR node"
		echo "25. Configure the host based firewall on AIR node"
		echo "26. SMTP and web server version shall not be disclosed on AIR node"
		echo "27. Change Default System Account Password"
		echo "28. Enable Audit Logging on AIR node"
		echo "29. Disable/Configure Weak SNMP Community String"
		echo "30. Run All Scripts on AIR node"
		echo "0.  Exit "
                echo "###########################################################################################"
                echo "# Please Enter the number corresponding with the checklist to execute scripts on AIR node #"
		echo "#------------------------You can enter 0 to exit from the scripts-------------------------#"
                echo "###########################################################################################"
                read scrnim
                echo $scrnim

                case $scrnim in
			1)
				. Disable_root.sh
				disable_root
				;;
			2)
				. vsftpd_disable.sh
				Disable
				;;
			3)
				. Lockout_timer.sh
				Lock
				;;
			4)
				. nfs-shares.sh
				nfs-shares
				;;
			5)
				. Con-Unauth.sh
				Conc
				;;
			6) 
				. SSHkey-Auth.sh
				keyb
				;;
			7)
				. Disable_inactive.sh
				Disable_inactive
				;;
			8)
				. PassRestriction.sh
				Restriction
				;;
			9)
				. Disable_Unused_Services.sh
				Services
				;;
			10)	
				. Timeout.sh
				ssht
				;;
			11)
				. anonymous.sh
				anonym
				;;
			12)     
				. X11forwarding.sh
				X11
				;;
			13)
				. Stack-Prot.sh
				Stack
				;;
			14)
				. Remove-cgi.sh
				Remove-cgi
				;; 
			15)
				. warning-banner.sh
				Warning
				;;
			16)	
				. Trace-httpd.sh
				Trace
				;;
			17)
				. Disable-weakSSL.sh
				Weak_SSL 
				;;
			18)
				. Disable-weakPro.sh
				SSL-Pro
				;;
			19)
				. Upgrade-http.sh
				Upgrade-http
				;;
			20)
				. Disable-weakCBC.sh
				Disable_Weak_CBC
				;;
			21)
				. rsyslog_Conf.sh
				rsyslog
				;;
			22)
				. Log_user.sh
				user_log
				;;
			23)
				. Restrict_AuditLogAccess.sh
				AuditLog_Restrict
				;;
			24)
				. Sec_Control_Validation.sh
				Security-Control
				;;
			25)
				. Configure_Firewall.sh
				firewalld
				;;
			26)
				. smtp_version.sh
				SMTP_Disclosure
				;;
			27)
				. Password_Change.sh
				Change_Acc_Password
				;;
			28)
				. Enable_Logging.sh
				auditlog1
				;;
			29)
				. Configure_Weak_Snmp.sh
				Weak_Snmp
				;;
			0)	. rollback.sh
				roll
				;;
			*)
				. Try-Again.sh
				Try
				. rollback.sh
				roll
				;;
			esac;;
	4)
		echo ""
		echo "The following scripts show the various security baselines compliance configurations on EMM. "
		echo "Please Enter the number between 1-29 associated with the appropriate script to run or enter "
		echo "You can enter 0 to exit the scripts for EMM"
		echo ""
		echo "1. Restrict Root Access on EMM node"
		echo "2. Disallow root access via FTP on EMM node"
		echo "3. Set Account Lockout Threshold for invalid logon attempts on EMM node"
		echo "4. Restrict mounting of NFS shares on EMM node"
		echo "5. Restrict concurrent unauthenticated user access from different terminals on EMM node"
		echo "6. Use of SSH key based authentication on EMM node"
		echo "7. Remove or disable inactive users on EMM node"
		echo "8. Set Password restriction, Complexity and Expiry on EMM node"
		echo "9. Disable insecure and unused services on EMM node"
		echo "10. Configure SSH Session Timeout on EMM node"
		echo "11. Disable Anonymous FTP login on EMM node"
		echo "12. Set X11 Protocol Forwarding on EMM node"
		echo "13. Enable Stack protection against buffer overflows on EMM node"
		echo "14. Disable/Remove CGI scripts on EMM node"
		echo "15. Create and enable warning banners on EMM node"
		echo "16. Disable Trace/Track in apache HTTPD on EMM node"
		echo "17. Disable SSL weak cipher(using RC4) in apache on EMM node"
		echo "18. Disable SSl Weak Protocols on EMM node"
		echo "19. Upgrade a supported version of apache HTTP server on EMM node"
		echo "20. Disable SSH Weak CBC Mode Ciphers on EMM node"
		echo "21. Configure remote syslog from UNIX server on EMM node"
		echo "22. Logging of user activities on OS level on EMM node"
		echo "23. Restrict access of audit logs on EMM node"
		echo "24. Provide screenshot for security control validation on EMM node"
		echo "25. Configure the host based firewall on EMM node"
		echo "26. SMTP and web server version shall not be disclosed on EMM node"
		echo "27. Change Default System Account Password"
		echo "28. Enable Audit Logging on EMM node"
		echo "29. Disable/Configure Weak SNMP Community String"
		echo "30. Enable and Prevent Direct login to database"
		echo "31. Enable Archive Logging"
		echo "0.  Exit "
                echo "###########################################################################################"
                echo "# Please Enter the number corresponding with the checklist to execute scripts on EMM node #"
		echo "#------------------------You can enter 0 to exit from the scripts-------------------------#"
                echo "###########################################################################################"
                read scrnim
                echo $scrnim

                case $scrnim in
			1)
				. Disable_root.sh
				disable_root
				;;
			2)
				. vsftpd_disable.sh
				Disable
				;;
			3)
				. Lockout_timer.sh
				Lock
				;;
			4)
				. nfs-shares.sh
				nfs-shares
				;;
			5)
				. Con-Unauth.sh
				Conc
				;;
			6) 
				. SSHkey-Auth.sh
				keyb
				;;
			7)
				. Disable_inactive.sh
				Disable_inactive
				;;
			8)
				. PassRestriction.sh
				Restriction
				;;
			9)
				. Disable_Unused_Services.sh
				Services
				;;
			10)	
				. Timeout.sh
				ssht
				;;
			11)
				. anonymous.sh
				anonym
				;;
			12)     
				. X11forwarding.sh
				X11
				;;
			13)
				. Stack-Prot.sh
				Stack
				;;
			14)
				. Remove-cgi.sh
				Remove-cgi
				;; 
			15)
				. warning-banner.sh
				Warning
				;;
			16)	
				. Trace-httpd.sh
				Trace
				;;
			17)
				. Disable-weakSSL.sh
				Weak_SSL 
				;;
			18)
				. Disable-weakPro.sh
				SSL-Pro
				;;
			19)
				. Upgrade-http.sh
				Upgrade-http
				;;
			20)
				. Disable-weakCBC.sh
				Disable_Weak_CBC
				;;
			21)
				. rsyslog_Conf.sh
				rsyslog
				;;
			22)
				. Log_user.sh
				user_log
				;;
			23)
				. Restrict_AuditLogAccess.sh
				AuditLog_Restrict
				;;
			24)
				. Sec_Control_Validation.sh
				Security-Control
				;;
			25)
				. Configure_Firewall.sh
				firewalld
				;;
			26)
				. smtp_version.sh
				SMTP_Disclosure
				;;
			27)
				. Password_Change.sh
				Change_Acc_Password
				;;
			28)
				. Enable_Logging.sh
				auditlog1
				;;
			29)
				. Configure_Weak_Snmp.sh
				Weak_Snmp
				;;
			30)
				. Disable_DB_Login.sh
				DB
				;;
			31)
				. Archive_logging.sh
				Archive-log
				;;	
			0)	. rollback.sh
				roll
				;;
			*)
				. Try-Again.sh
				Try
				. rollback.sh
				roll
				;;	
			esac;;
	5)
		echo ""
		echo "The following scripts show the various security baselines compliance configurations on ECMS. "
		echo "Please Enter the number between 1-29 associated with the appropriate script to run or enter "
		echo "You can enter 0 to exit the scripts for ECMS"
		echo ""
		echo "1. Restrict Root Access on ECMS node"
		echo "2. Disallow root access via FTP on ECMS node"
		echo "3. Set Account Lockout Threshold for invalid logon attempts on ECMS node"
		echo "4. Restrict mounting of NFS shares on ECMS node"
		echo "5. Restrict concurrent unauthenticated user access from different terminals on ECMS node"
		echo "6. Use of SSH key based authentication on ECMS node"
		echo "7. Remove or disable inactive users on ECMS node"
		echo "8. Set Password restriction, Complexity and Expiry on ECMS node"
		echo "9. Disable insecure and unused services on ECMS node"
		echo "10. Configure SSH Session Timeout on ECMS node"
		echo "11. Disable Anonymous FTP login on ECMS node"
		echo "12. Set X11 Protocol Forwarding on ECMS node"
		echo "13. Enable Stack protection against buffer overflows on ECMS node"
		echo "14. Disable/Remove CGI scripts on ECMS node"
		echo "15. Create and enable warning banners on ECMS node"
		echo "16. Disable Trace/Track in apache HTTPD on ECMS node"
		echo "17. Disable SSL weak cipher(using RC4) in apache on ECMS node"
		echo "18. Disable SSl Weak Protocols on ECMS node"
		echo "19. Upgrade a supported version of apache HTTP server on ECMS node"
		echo "20. Disable SSH Weak CBC Mode Ciphers on ECMS node"
		echo "21. Configure remote syslog from UNIX server on ECMS node"
		echo "22. Logging of user activities on OS level on ECMS node"
		echo "23. Restrict access of audit logs on ECMS node"
		echo "24. Provide screenshot for security control validation on ECMS node"
		echo "25. Configure the host based firewall on ECMS node"
		echo "26. SMTP and web server version shall not be disclosed on ECMS node"
		echo "27. Change Default System Account Password"
		echo "28. Enable Audit Logging on ECMS node"
		echo "29. Disable/Configure Weak SNMP Community String"
		echo "30. Enable and Prevent Direct login to database"
		echo "31. Enable Archive Logging"
		echo "0.  Exit "
                echo "############################################################################################"
                echo "# Please Enter the number corresponding with the checklist to execute scripts on ECMS node #"
		echo "#------------------------You can enter 0 to exit from the scripts--------------------------#"
                echo "############################################################################################"
                read scrnim
                echo $scrnim

                case $scrnim in
			1)
				. Disable_root.sh
				disable_root
				;;
			2)
				. vsftpd_disable.sh
				Disable
				;;
			3)
				. Lockout_timer.sh
				Lock
				;;
			4)
				. nfs-shares.sh
				nfs-shares
				;;
			5)
				. Con-Unauth.sh
				Conc
				;;
			6) 
				. SSHkey-Auth.sh
				keyb
				;;
			7)
				. Disable_inactive.sh
				Disable_inactive
				;;
			8)
				. PassRestriction.sh
				Restriction
				;;
			9)
				. Disable_Unused_Services.sh
				Services
				;;
			10)	
				. Timeout.sh
				ssht
				;;
			11)
				. anonymous.sh
				anonym
				;;
			12)     
				. X11forwarding.sh
				X11
				;;
			13)
				. Stack-Prot.sh
				Stack
				;;
			14)
				. Remove-cgi.sh
				Remove-cgi
				;; 
			15)
				. warning-banner.sh
				Warning
				;;
			16)	
				. Trace-httpd.sh
				Trace
				;;
			17)
				. Disable-weakSSL.sh
				Weak_SSL 
				;;
			18)
				. Disable-weakPro.sh
				SSL-Pro
				;;
			19)
				. Upgrade-http.sh
				Upgrade-http
				;;
			20)
				. Disable-weakCBC.sh
				Disable_Weak_CBC
				;;
			21)
				. rsyslog_Conf.sh
				rsyslog
				;;
			22)
				. Log_user.sh
				user_log
				;;
			23)
				. Restrict_AuditLogAccess.sh
				AuditLog_Restrict
				;;
			24)
				. Sec_Control_Validation.sh
				Security-Control
				;;
			25)
				. Configure_Firewall.sh
				firewalld
				;;
			26)
				. smtp_version.sh
				SMTP_Disclosure
				;;
			27)
				. Password_Change.sh
				Change_Acc_Password
				;;
			28)
				. Enable_Logging.sh
				auditlog1
				;;
			29)
				. Configure_Weak_Snmp.sh
				Weak_Snmp
				;;
			30)
				. Disable_DB_Login.sh
				DB
				;;
			31)
				. Archive_logging.sh
				Archive-log
				;;	
			0)	. rollback.sh
				roll
				;;
			*)
				. Try-Again.sh
				Try
				. rollback.sh
				roll
				;;		
			esac;;
	0)
		. rollback.sh
		roll
		;;
	*)
		. Try.sh
		try
		. rollback.sh
		roll
		;;
esac
}
Master | tee -a /var/log/script_actions_logs.$(date "+%Y-%m-%d_%H-%M-%S").txt
