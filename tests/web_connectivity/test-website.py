#!/usr/bin/env python3

import argparse

parser = argparse.ArgumentParser(description ='Test website connectivity')
parser.add_argument('--url', dest ='url',
                    required = True,
                    action ='store', help ='URL to query')
parser.add_argument('--searchstring', dest ='searchstring',
                    required = True,
                    action ='store', help ='Text to evaluate')
args = parser.parse_args()

url = args.url
searchstring = args.searchstring

def page_availability():
  from urllib.request import Request, urlopen
  from urllib.error import URLError
  req = Request(url)
  try:
      response = urlopen(req)
  except URLError as e:
      if hasattr(e, 'reason'):
          return('We failed to reach a server.  Reason: ', e.reason)
      elif hasattr(e, 'code'):
          return('The server couldn\'t fulfill the request.  Error code: ', e.code)
  else:
      return('We\'re good to go')

def search_page_content():
  import urllib.request
  import re
  with urllib.request.urlopen(url) as response:
    html = response.read().decode('utf-8')
    matches = re.findall(searchstring, html)
    if len(matches) == 0:
      return('No matches for the phrase \"' + searchstring + '\" found!')
    else:
      return('The phrase \"' + searchstring + '\" has been found!')

def test_page_availability():
  assert page_availability() == "We're good to go", "Page not available"
  print('page_availability Test Passed')

def test_page_content():
  assert search_page_content() == 'The phrase \"' + searchstring + '\" has been found!', "The phrase wasn't found"
  print('page_content Test Passed')

test_page_availability()

test_page_content()
