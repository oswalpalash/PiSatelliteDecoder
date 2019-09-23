#!/bin/sh

if pgrep "rtl_fm" > /dev/null
then
	exit 1
fi

sudo timeout $6 rtl_fm -M fm -f ${2}M -s 48k -g 50 -p 55 -E wav -E deemp -F 9 - | sox -t raw -e signed -c 1 -b 16 -r 48000 - $3.wav rate 11025
