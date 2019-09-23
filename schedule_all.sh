#!/bin/bash

# Update Satellite Information

wget -qr https://www.celestrak.com/NORAD/elements/weather.txt -O /home/pi/weather/predict/weather.txt
wget -qr http://www.celestrak.com/NORAD/elements/amateur.txt -O /home/pi/weather/predict/amateur.txt
grep "NOAA 15" /home/pi/weather/predict/weather.txt -A 2 > /home/pi/weather/predict/weather.tle
grep "NOAA 18" /home/pi/weather/predict/weather.txt -A 2 >> /home/pi/weather/predict/weather.tle
grep "NOAA 19" /home/pi/weather/predict/weather.txt -A 2 >> /home/pi/weather/predict/weather.tle
grep "METEOR-M 2" /home/pi/weather/predict/weather.txt -A 2 >> /home/pi/weather/predict/weather.tle
grep "ZARYA" /home/pi/weather/predict/amateur.txt -A 2 > /home/pi/weather/predict/amateur.tle

#Remove all AT jobs
for i in `atq | awk '{print $1}'`;do atrm $i;done


#Prune Older Data 
find /home/pi/weather/ -type f -name '*.png' -mtime +2 -exec rm -f {} \;
find /home/pi/weather/ -type f -name '*.jpg' -mtime +2 -exec rm -f {} \;
find /home/pi/weather/ -type f -name '*.wav' -mtime +2 -exec rm -f {} \;

#Schedule Satellite Passes:

/home/pi/weather/predict/schedule_sat.sh "NOAA 19" 137.1000
/home/pi/weather/predict/schedule_sat.sh "NOAA 18" 137.9125
/home/pi/weather/predict/schedule_sat.sh "NOAA 15" 137.6200
/home/pi/weather/predict/schedule_iss.sh "ISS" 145.8000 
