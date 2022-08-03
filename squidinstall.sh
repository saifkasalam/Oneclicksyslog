#!/bin/bash
	read -p "Enter client Ip Address or cidr (ex-10.0.0.0/16) : " value1
	sudo apt update -y
	sudo apt install -y squid 

#Disabling All Private Subnets
	sudo sed -i 's/acl localnet src 0.0.0.1-0.255.255.255/#acl localnet src 0.0.0.1-0.255.255.255/g' /etc/squid/squid.conf
	sudo sed -i 's|acl localnet src 10.0.0.0/8|#acl localnet src 10.0.0.0/8|g' /etc/squid/squid.conf
	sudo sed -i 's|acl localnet src 100.64.0.0/10|#acl localnet src 100.64.0.0/10|g' /etc/squid/squid.conf
	sudo sed -i 's|acl localnet src 169.254.0.0/16|#acl localnet src 169.254.0.0/16|g' /etc/squid/squid.conf
	sudo sed -i 's|acl localnet src 172.16.0.0/12|#acl localnet src 172.16.0.0/12|g' /etc/squid/squid.conf
	sudo sed -i 's|acl localnet src 192.168.0.0/16|#acl localnet src 192.168.0.0/16|g' /etc/squid/squid.conf
	sudo sed -i 's|acl localnet src fc00::/7|#acl localnet src fc00::/7|g' /etc/squid/squid.conf
	sudo sed -i 's|acl localnet src fe80::/10|#acl localnet src fe80::/10|g' /etc/squid/squid.conf

#Creating The Whitelist.txt File
 	sudo touch /etc/squid/whitelist.txt
	echo -e ".tcsion.com\n.tcs.com\n.secugen.com" |sudo  tee -a /etc/squid/whitelist.txt


#Add values to Config file
	sudo sed -i 's/http_access deny all/#http_access deny all/g' /etc/squid/squid.conf
	sudo echo acl localnet src  "$value1" >> /etc/squid/squid.conf
        sudo echo acl ion dstdomain '"/etc/squid/whitelist.txt"' >> /etc/squid/squid.conf
        sudo echo http_access allow ion >> /etc/squid/squid.conf
	sudo echo http_access deny all >> /etc/squid/squid.conf	

#Restart squid
	sudo systemctl restart squid
	sudo systemctl enable squid
