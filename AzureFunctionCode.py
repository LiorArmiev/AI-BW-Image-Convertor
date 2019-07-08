import os
import sys, os.path , io
import numpy as np
import argparse
import cv2
import urllib.request
import logging
import json
import platform
#sys.path.append('D:/home/site/tools/Lib/site-packages')

postreqdata = json.loads(open(os.environ['req']).read())
response = open(os.environ['res'], 'w')
response.write("Img URL: {0}".format(postreqdata['imageurl'])) 

print("[INFO] loading model...")
net = cv2.dnn.readNetFromCaffe("D:/home/site/tools/colorization_deploy_v2.prototxt", "D:/home/site/tools/colorization_release_v2.caffemodel")
pts = np.load("D:/home/site/tools/pts_in_hull.npy")
print("[INFO] start engine...")
class8 = net.getLayerId("class8_ab")
conv8 = net.getLayerId("conv8_313_rh")
pts = pts.transpose().reshape(2, 313, 1, 1)
net.getLayer(class8).blobs = [pts.astype("float32")]
net.getLayer(conv8).blobs = [np.full([1, 313], 2.606, dtype="float32")]

uri = postreqdata['imageurl']
imageName = "".join(uri.split("/")[-1:])
imageNameBW = imageName.split(".")[0] + "_BW." + imageName.split(".")[1]
imageNameRGB = imageName.split(".")[0] + "_RGB." + imageName.split(".")[1]
print(imageNameBW)
print(imageNameRGB)

image = urllib.request.urlretrieve(uri,imageNameBW)
image = cv2.imread(imageNameBW)

scaled = image.astype("float32") / 255.0
lab = cv2.cvtColor(scaled, cv2.COLOR_BGR2LAB)

resized = cv2.resize(lab, (224, 224))
L = cv2.split(resized)[0]
L -= 50

'print("[INFO] colorizing image...")'
net.setInput(cv2.dnn.blobFromImage(L))
ab = net.forward()[0, :, :, :].transpose((1, 2, 0))

ab = cv2.resize(ab, (image.shape[1], image.shape[0]))

L = cv2.split(lab)[0]
colorized = np.concatenate((L[:, :, np.newaxis], ab), axis=2)
colorized = cv2.cvtColor(colorized, cv2.COLOR_LAB2BGR)
colorized = np.clip(colorized, 0, 1)
colorized = (255 * colorized).astype("uint8")

cv2.imwrite(imageNameRGB,colorized)

from azure.storage.blob import BlockBlobService
blob_service = BlockBlobService(account_name="CAHNGE STROAGE ACCOUNT NAME",account_key="CHANGE KEY")
blob_service.create_blob_from_path("cv-bw-2-color", imageNameRGB, imageNameRGB)
blob_service.create_blob_from_path("cv-bw-2-color", imageNameBW, imageNameBW)

cv2.waitKey(0)
