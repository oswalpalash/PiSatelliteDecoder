#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import os
import sys
import tweepy

CONSUMER_KEY = ''
CONSUMER_SECRET = ''
ACCESS_TOKEN_KEY = ''
ACCESS_TOKEN_SECRET = ''

auth = tweepy.OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
auth.set_access_token(ACCESS_TOKEN_KEY, ACCESS_TOKEN_SECRET)
api = tweepy.API(auth)
IndiaFlag = u'\U0001F1EE' + u'\U0001F1F3'

filenames = []
for element in sys.argv[3:]:
  filenames.append(element)

media_ids = []
for filename in filenames:
  res = api.media_upload(filename)
  media_ids.append(res.media_id)

api.update_status(status=IndiaFlag + ' Satellite Image: ' + sys.argv[1] + '. Maximum Elevation: ' + sys.argv[2] + ' degrees. #weather #indiaimages #noaasatellite #climate #india #indiasat #incredibleindia #photography #travel #photooftheday'  , media_ids=media_ids)
