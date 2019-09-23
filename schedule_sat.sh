#!/bin/bash

#echo "/home/pi/weather/predict/receive_and_process_satellite.sh \"${1}\" $2 /home/pi/weather/${1//" "}${OUTDATE} /home/pi/weather/predict/weather.tle $var1 $TIMER"  | at `date --date="TZ=\"UTC\" $START_TIME" +"%H:%M %D"`

# $1 is Name of Satellite
# $2 is Frequency to Record


/home/pi/weather/predict/fetch.py "${1}" | while read line
do
	START=$(echo $line | awk '{print $1}')
	TIMER=$(echo $line | awk '{print $2}')
	OUTDATE=$(echo $line | awk '{print $5}')
	ATTIME=$(echo $line | awk '{print $3 " " $4}')
	MAXEL=$(echo $line | awk '{print $6}' )
	echo "/home/pi/weather/predict/receive_and_process_satellite.sh \"${1}\" $2 /home/pi/weather/${1//" "}${OUTDATE} /home/pi/weather/predict/weather.tle $START $TIMER $MAXEL"  | at $ATTIME
	echo "$1 SCHEDULED AT $ATTIME WITH ELEVATION $MAXEL"
done
