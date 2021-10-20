% This is a sample script
% It demos the face expression recognition using the Eigenface method

disp('RECONOCIMIENTO EXPRESIONES FACIALES')

%pictureCapture

TrainImagePath = 'C:\Users\samuel\Desktop\RECONOCIMIENTO_EXPRECIONES_FACIALES\Project Code\BASE_DATOS';
TestImagePath = 'C:\Users\samuel\Desktop\RECONOCIMIENTO_EXPRECIONES_FACIALES\Project Code\Imagenes_de_prueba';
LabelPath = 'C:\Users\samuel\Desktop\RECONOCIMIENTO_EXPRECIONES_FACIALES\Project Code\ETIQUETAS_IMAGENES.txt';

[NumTrainImg,TrainImg] = loadImage( TrainImagePath );
[NumTestImg,TestImg] = loadImage( TestImagePath );

[C,minDist,minDistIndex] = eigenFaceRecognition(TrainImg,TestImg,NumTrainImg,NumTestImg );

% Display the result
RecognizedExpression = strcat(int2str(minDistIndex),'.jpg');
    % read in the image label
    fid=fopen(LabelPath);
    imageLabel=textscan(fid,'%s %s','whitespace',',');
    fclose(fid);

    % export the matched label
    Best_Match = cell2mat(imageLabel{1,1}(minDistIndex));
    ExprLabel = cell2mat(imageLabel{1,2}(minDistIndex));

%str1 = strcat('Your face expression is like this one:  ',RecognizedExpression);
str2 = strcat('PODEMOS DECIR QUE TE ENCUENTRAS:  ',ExprLabel);
%disp(str1)
disp(str2)

%SelectedImage = strcat(TrainImagePath,'\',RecognizedExpression);
%SelectedImage = imread(SelectedImage);
%imshow(SelectedImage)