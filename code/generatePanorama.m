function [outputimg] = generatePanorama(img1,img2)


[locs1,locs2,matches] = testMatch(img1,img2);
[bestH] = ransacH(matches,locs1,locs2,5000,3);
outputimg = imageStitching_noClip(img1,img2,bestH);
imwrite(outputimg,'../results/q6_3.jpg');


end