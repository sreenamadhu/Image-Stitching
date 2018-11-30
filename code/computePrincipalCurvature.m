function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid

PrincipalCurvature=zeros(size(DoGPyramid));
% R is principal curvature ratio matrix 
for gauss_num = 1: size(DoGPyramid,3)
    % Taking one gaussian blur image 
    temp=DoGPyramid(:,:,gauss_num);
    % 1st orderderivatives dx and dy
    [dx,dy]=gradient(temp);
    % Second derivatives
    [dxdx,dydx]=gradient(dx);
    [dxdy,dydy]=gradient(dy);
    % traversing for every pixel,now...
    for row = 1:size(temp,1)
        for col = 1:size(temp,2)
            R = [dxdx(row,col),dxdy(row,col);dydx(row,col),dydy(row,col)];
                        
            PrincipalCurvature(row,col,gauss_num) = (trace(R).^2) ./ det(R) ;
            
        end
    end

end


    

end