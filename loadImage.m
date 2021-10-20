function [numImage,img] = loadImage( strImagePath )

% Construyendo imagen, gargando espacio and contando el numero de imagenes
structImages = dir(strImagePath);
lenImages = length(structImages);
Images='';

if (lenImages==0)
    disp('Error: No image was detected in the Image Folder');
    return;
end

i=0;
for j = 3:lenImages
     if ((~structImages(j).isdir))
         if  (structImages(j).name(end-3:end)=='.jpg')
             i=i+1;
             Images{i,1} = [strImagePath,'\',structImages(j).name];
         end
     end
end
numImage = i; % este es el numero de imagenes cargadas

% All Images are resized into a common size
imageSize = [280,180]; 


% Loading images
img = zeros(imageSize(1)*imageSize(2),numImage);
for i = 1:numImage
    aa = imresize(faceDetection(imresize(imread(Images{i,1}),[375,300])),imageSize);
    img(:,i) = aa(:);
    % disp(sprintf('Loading Image # %d',i));
end
% Generating the promedio de imagenes
meanImage = mean(img,2);        

% Substracting the promedio de las imagenes de loaded image
img = (img - meanImage*ones(1,numImage))';     
end

