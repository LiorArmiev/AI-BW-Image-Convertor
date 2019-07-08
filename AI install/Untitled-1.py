import os
import sys, os.path , io
import numpy as np
import argparse
import cv2
import urllib.request
import logging
import json
import platform

postreqdata = json.loads(open(os.environ['req']).read())
response = open(os.environ['res'], 'w')
response.write("Python version: {0}".format(platform.python_version())) 
print (postreqdata)
print ("version", sys.version)
sys.path.append('D:/home/site/tools/Lib/site-packages')