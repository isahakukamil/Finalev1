#!/bin/bash

Upgrade-http() {
echo "########################################################"
echo "##------Script to Upgrade HTTP Server on IN nodes-----##"
echo "##--------Name:Issahaku Kamil | UserID : EKAMISS------##"
echo "########################################################"


echo ""
echo "Displaying the current version and info about the HTTP server installed.."
echo ""
yum info httpd
sleep 5
echo ""
yum install yum-changelog
sleep 2
echo ""
yum changelog httpd
sleep 2
yum install -y epel-release
sleep 2
echo ""
cd /etc/yum.repos.d && wget https://repo.codeit.guru/codeit.el`rpm -q --qf "{%version}" $(rpm -q --whatprovides redhat-release)`.repo
sleep 2
echo ""
echo "Upgrading to new version of httpd server"
yum install -y httpd
sleep 5 
echo ""
systemctl start httpd

. rollback.sh
roll

}

