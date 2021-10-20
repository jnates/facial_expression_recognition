function [C,minDist,minDistIndex] = eigenFaceRecognition(TrainImg,TestImg,NumTrainImg,NumTestImg )

% funicion del PCA para entrenar la imagen generada por loadImage.m 
[C,S,L]=princomp(TrainImg,'econ');                   
EigenRange = [1:30];   % Definiendo el rango ode Eigenvalues que pudieran ser seleccionados
C = C(:,EigenRange);

% proyectando la imagen de prueba en el espacio de la cara
ProjectedTestImg = TestImg * C;

% calculando distancias  euclidianas
EucDist = zeros(NumTestImg,NumTrainImg);
for projectedImgIndex = 1:NumTestImg
    TestImage = ProjectedTestImg(projectedImgIndex,:);
    for i = 1:NumTrainImg
        EucDist(projectedImgIndex,i) = sqrt((TestImage'-S(i,EigenRange)')' ...
            *(TestImage'-S(i,EigenRange)'));
    end
end
[minDist,minDistIndex] = min(EucDist,[],2);

end

