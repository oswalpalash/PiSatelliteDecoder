#!/usr/bin/python3

import requests
import sys
import time

API_KEY=''
LAT=''
LON=''
ALT=''

sat_name = sys.argv[1]
if sat_name == "NOAA 15":
    sat_num = 25338
elif sat_name == "NOAA 18":
    sat_num = 28654
elif sat_name == "NOAA 19":
    sat_num = 33591
elif "ISS" in sat_name:
    sat_num = 25544

if sat_num == 25544:
    min_el = 20
else:
    min_el = 25

URL = "https://www.n2yo.com/rest/v1/satellite/radiopasses/" + str(sat_num) + "/" + str(LAT) + "/" + str(LON) + "/" + str(ALT) + "/1/" + str(min_el) +  "/&apiKey=" + API_KEY

data = requests.get(URL).json()
try:
    for record in data['passes']:
        startUTC = record['startUTC']
        endUTC = record['endUTC']
        maxEl = record['maxEl']
        duration = endUTC-startUTC
        # DOING MATH HERE
        startUTC = int(startUTC + ( duration/3 ))
        endUTC = int(endUTC - ( duration/3 ))
        timeF = time.strftime('%H:%M %D', time.localtime(startUTC))
        timeO = time.strftime('%Y%m%d-%H%M%S', time.localtime(startUTC))
        print(startUTC,endUTC-startUTC,timeF,timeO,maxEl)
except KeyError:
    exit(0)
