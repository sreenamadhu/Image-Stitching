% Script to test BRIEF under rotations

function briefRotTest()


im1=imread('../data/model_chickenbroth.jpg');
% Converting to gray
im1=im2double(im1);

if size(im1,3)==3 
    im1=rgb2gray(im1);
end

im2=im1;
n=1;
deg= 10 : 10 :360;
[locs1, desc1] = briefLite(im1);
for i = 10 : 10 :360
   
    im2=imrotate(im1,i);
    
    [locs2, desc2] = briefLite(im2);
    [matches]=briefMatch(desc1,desc2);
    correct(n)=length(matches);
    n=n+1;
    
end
figure;
bar(deg,correct);
title('2.5 BRIEF and rotations');
xlabel('Rotation Angle');
ylabel('Number of Correct Matches');
end