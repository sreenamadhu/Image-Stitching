function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC




% RANSAC ALGORITHM
%1. select 4 feature pairs (random) 
% 2. calculate h by these 4 points 
% 3. check the dist 
% Run 1,2,3,... for nIter times
% calculate h for all these points

tot_p1=[];
tot_p2=[];
inliners_prob=tol*0.1;
x=0;
% Running niter times in search of best inliners
P1=locs1(matches(:,1),1:2)';
P2=locs2(matches(:,2),1:2)';
P2(3,:)=ones(1,size(P2,2));
P1(3,:)=ones(1,size(P1,2));
prev_count=0;
for n = 1: nIter
    pairs=randperm(size(matches,1),4);
    p1=locs1(matches(pairs,1),1:2)';
    p2=locs2(matches(pairs,2),1:2)';
    h=computeH(p2,p1);
    P1_new=h*P2;
    P1_new=P1_new./P1_new(3,:);
    ssd=sqrt(sum((P1_new-P1).^2));
    ssd = ssd <tol;
    inliners = find(ssd) ;
    if inliners
        count_inliners=sum(ssd);
        if count_inliners > prev_count 
            tot_p1 = P1(:,inliners);
            tot_p2 = P2(:,inliners);
            prev_count = count_inliners;
        end
        
    end
    
   
end
tot_p2=tot_p2(1:2,:);
tot_p1=tot_p1(1:2,:);
bestH=computeH(tot_p2,tot_p1);
end

