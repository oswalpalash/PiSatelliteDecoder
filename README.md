# Automating Satellite Capture and Decode using RTL-SDR and Raspberry Pi 

Based on the Blog Post : [automating-satellite-capture-and-decode-using-rtl-sdr-and-raspberry-pi](https://oswalpalash.com/automating-satellite-capture-and-decode-using-rtl-sdr-and-raspberry-pi)

### Features!
  - Timestamp and satellite name over every image.
  - WXToIMG configured to create several images (HVC,HVCT,MCIR, etc).
  - Pictures are posted to Twitter. See more at [NOAA Bot India twitter account](https://twitter.com/BotNoaa).
  - Code is updated on how it handles the UTC vs timezone times.
  - Calculates Elevation of Sun to determine day-night


### Configuration

#### Set your Twitter credentials
Go to [Twitter Developer site](http://developer.twitter.com/) and apply for a developer account.
Set your credentials on post.py
```
CONSUMER_KEY = ''
CONSUMER_SECRET = ''
ACCESS_TOKEN_KEY = ''
ACCESS_TOKEN_SECRET = ''
```

#### Set your n2yo.com API credentials and location
Get your API Credentials (for free) from n2yo.com and add them to fetch.py
```
API_KEY=''
LAT=''
LON=''
ALT=''
``` 

#### Add Location for sun elevation
In sun.py add your location
```
obs.lat=''
obs.long=''
```
