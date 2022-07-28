#!/bin/bash
read -p "Enter Value1 : " data1
read -p "Enter Value2 : " data2
read -p "Enter Value3 : " data3


#grep "$data1" /var/log/xyz/xyz.log | grep "$data2" | grep "$data3" 
grep "$data1" /var/log/8046/8046L1.log | grep "$data2" | grep "$data3" 

