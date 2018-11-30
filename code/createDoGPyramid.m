function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)
%%Produces DoG Pyramid
% inputs
% Gaussian Pyramid - A matrix of grayscale images of size
%                    (size(im), numel(levels))
% levels      - the levels of the pyramid where the blur at each level is
%               outputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%               created by differencing the Gaussian Pyramid input

    %Initialising the Dog filter to be of size RXCX(L-1)
    DoGPyramid=zeros(size(GaussianPyramid,1),size(GaussianPyramid,2),size(GaussianPyramid,3)-1);
    DoGLevels=zeros(1,numel(levels)-1)
    for i = 2 : numel(levels)
        % for levels l,l-1,....,2
        
        DoGPyramid(:,:,i-1) = GaussianPyramid(:,:,i)-GaussianPyramid(:,:,i-1);
        DoGLevels(i-1)=levels(i);
        
    end
end
