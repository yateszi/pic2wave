from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import numpy as np
import argparse
import utils
import cv2

#args
ap = argparse.ArgumentParser();
ap.add_argument("-i","--image",required=True,help="path to image");
ap.add_argument("-c","--clusters",required=True,type = int,help="# of clusters");
args = vars(ap.parse_args());

# loat image & BGRTORGB
image = cv2.imread(args["image"]);
img = cv2.imread(args["image"]);
image = cv2.cvtColor(image,cv2.COLOR_BGR2RGB);
#image = cv2.threhold(image,
img = cv2.resize(image,(160,120))
#img = cv2.resize(image,(160,320))
image = img;

#show orig
plt.figure();
plt.axis("off");
plt.imshow(image);

# reshape the image to be a list of pixels
image = image.reshape((image.shape[0] * image.shape[1],3));
#image = image.reshape((image.shape[0] * image.shape[1],1));

# cluster 
clt = KMeans(n_clusters = args["clusters"]);
clt.fit(image);

center = np.uint8(clt.cluster_centers_);
print center;
#img_out = center[clt.labels_.flatten()];
img_out = clt.labels_.flatten()[:];
plt.figure();
plt.axis("off");
with open("img_out.txt","w") as fp:
    for it in img_out:
#print(it);
        fp.write(str(it)+"\n");
plt.imshow(img_out.reshape((img.shape[0:2])));

print("img_size is {}x{}".format(img.shape[1],img.shape[0]));
hist = utils.centroid_histogram(clt);
bar = utils.plot_colors(hist,clt.cluster_centers_);

plt.figure();
plt.axis("off");
plt.imshow(bar);
plt.show()
