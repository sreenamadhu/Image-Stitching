function H2to1 = computeH(p1,p2)
% INPUTS:
% p1 and p2 - Each are size (2 x N) matrices of corresponding (x, y)'  
%             coordinates between two images
%
% OUTPUTS:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear 
%         equation

    
    %X1- should be 2xN matrix, X2- should be 2xN matrix , N number of
    %points 
    
    %------N points are considered randomly, consider 256 .....
    
    
    
    % p1,p2 ... first 100 keypoint locations
    %Iterating through each datapoint.....
    n=1;
    for i = 1: size(p1,2)
           
           x1=p1(1,i);
           y1=p1(2,i);
           x1_1=p2(1,i);
           y1_1=p2(2,i);
           A(n,:)=[x1 y1 1 0 0 0 -x1*x1_1 -y1*x1_1 -x1_1];
           A(n+1,:)= [0 0 0 x1 y1 1 -x1*y1_1 -y1*y1_1 -y1_1];
           n=n+2;
    end
        
    [U,S,V]=svd(A);
    H2to1 = V(:,9);
%     if size(S,1) == 8 
%         H2to1= V(:,end-1);
%     else
%         H2to1 = V(:,end);
%     end
   
    H2to1=reshape(H2to1,[3,3])';
    
end