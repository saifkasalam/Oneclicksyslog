#!/bin/bash
read -p "Enter Tc-Code : " value1
read -p "Enter LAN number (1,2,3,..) : " value2

sudo mkdir /var/log/"$value1" && \

sudo chown -R syslog:adm /var/log/"$value1"

sudo touch /var/log/"$value1"/"$value1"L"$value2".log

sudo chown -R syslog:adm /var/log/"$value1"/"$value1"L"$value2".log

sudo apt update -y

sudo apt install -y rsyslog 

sudo apt install -y ntp

sudo sed -i 's/#module(load="imudp")/module(load="imudp")/g' /etc/rsyslog.conf
sudo sed -i 's/#input(type="imudp" port="514")/input(type="imudp" port="514")/g' /etc/rsyslog.conf


sudo sed -i 's/#module(load="imtcp")/module(load="imtcp")/g' /etc/rsyslog.conf
sudo sed -i 's/#input(type="imtcp" port="514")/input(type="imtcp" port="514")/g' /etc/rsyslog.conf

sudo echo local7.* /var/log/"$value1"/"$value1"L"$value2".log >> /etc/rsyslog.d/50-default.conf

sudo service rsyslog restart

sudo cp query.sh /var/log/"$value1"/query.sh

sudo sed -i 's|replaceme|/var/log/'"$value1"'/'"$value1"'L'"$value2"'.log|g' /var/log/"$value1"/query.sh

sudo chmod +x /var/log/"$value1"/query.sh

sudo rm /usr/bin/query

sudo ln -s /var/log/"$value1"/query.sh /usr/local/bin/query
