#!/bin/bash

FILE_SLAVES='/sys/devices/w1_bus_master1/w1_master_slaves'
FILE_REMOVE='/sys/devices/w1_bus_master1/w1_master_remove'
FILE_SEARCH='/sys/devices/w1_bus_master1/w1_master_search'

echo "Start scanning for 1-Wire Devices"

while test 1
do
	while read line;
	do
		if [ "$line" != 'not found.' ]
			then
			echo "${line}" > $FILE_REMOVE
		fi
	done < $FILE_SLAVES

	echo 1 > $FILE_SEARCH
	sleep 0.5

	slaves=$( cat "$FILE_SLAVES" )
	if [ "$slaves" != 'not found.' ] 
		then
		NOW=$(date +"%m-%d-%Y %H:%M:%S")
		echo "[$NOW] $slaves"
	fi

	sleep 0.5
done

