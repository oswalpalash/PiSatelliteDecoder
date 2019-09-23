#!/bin/bash

# $1 = Satellite Name
# $2 = Frequency
# $3 = FileName base
# $4 = TLE File
# $5 = EPOC start time
# $6 = Time to capture
# $7 = Max Elevation

if pgrep "rtl_fm" > /dev/null
then
	exit 1
fi

START_DATE=$(date '+%d-%m-%Y %H:%M')
sudo timeout $6 rtl_fm -f ${2}M -s 60k -g 50 -p 55 -E wav -E deemp -F 9 - | sox -t raw -e signed -c 1 -b 16 -r 60000 - $3.wav rate 11025


PassStart=`expr $5 + 90`

SUN_ELEV=$(/home/pi/weather/predict/sun.py $PassStart)
SUN_MIN_ELEV=15

if [ "${SUN_ELEV}" -gt "${SUN_MIN_ELEV}" ]; then
	ENHANCEMENTS="ZA MCIR MCIR-precip MSA MSA-precip HVC-precip HVCT-precip HVC HVCT"
else
	ENHANCEMENTS="ZA MCIR MCIR-precip"
fi

/usr/local/bin/wxmap -T "${1}" -H "${4}" -p 0 -l 0 -o ${PassStart} ${3}-map.png

for i in $ENHANCEMENTS; do
	/usr/local/bin/wxtoimg -o -m ${3}-map.png -e $i ${3}.wav ${3}-$i.png		
        /usr/local/bin/wxtoimg -o -m ${3}-map.png -e $i ${3}.wav ${3}-$i.jpg
	/usr/bin/convert ${3}-$i.png -undercolor black -fill yellow -pointsize 18 -annotate +20+20 "${1} $i ${START_DATE}" ${3}-$i.png		
        /usr/bin/convert -quality 90 -format jpg ${3}-$i.jpg -undercolor black -fill yellow -pointsize 18 -annotate +20+20 "${1} $i ${START_DATE}" ${3}-$i.jpg
done	

/usr/local/bin/wxtoimg -m ${3}-map.png -e ZA $3.wav $3.jpg


if [ "${SUN_ELEV}" -gt "${SUN_MIN_ELEV}" ]; then
	/home/pi/weather/predict/post.py "$1 ${START_DATE}" "$7" $3-MCIR-precip.jpg $3-MSA-precip.jpg $3-HVC-precip.jpg $3-HVCT-precip.jpg
else
	/home/pi/weather/predict/post.py "$1 ${START_DATE}" "$7" $3-MCIR-precip.jpg $3-MCIR.jpg $3.jpg
fi
