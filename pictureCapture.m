function pictureCapture
%activa la camara frontal del portatil
frontCam = videoinput('winvideo', 1,'YUY2_640x480');
set(frontCam,'TriggerRepeat',inf);
set(frontCam,'FramesPerTrigger',1);
set(frontCam,'ReturnedColorSpace','rgb');
vidRes=get(frontCam,'VideoResolution');
nBands=get(frontCam,'NumberOfBands');

%globalizar vidRes y nBands en las funciones de la Guide de los botones de prender
%camar y tomar foto
%axes(handles.axes2);
% activar un figure y utilizarlo para calculos futuros
fig1 = figure(2);
set(fig1,'doublebuffer','on');
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
set(fig1,'Name','    Por favor de clic izquierdo para capturar la imagen');
set(fig1,'WindowButtonDownFcn',@LeftClickFcn);

fig2 = 0;
% uno sola vez click izquierdo, una sola imagen puede ser capturada
% la ultima imagen sera guardada por defecto como "snap.jpg"
    function LeftClickFcn(~,~)
        frame = getsnapshot(frontCam);
        if fig2 == 0
            fig2 = figure;
        else
            figure(fig2)
        end
        imshow(frame);
        title('la imagen fue capturadaˇˇ^_< ')
        imwrite(frame,'C:\Users\samuel\Desktop\RECONOCIMIENTO_EXPRECIONES_FACIALES\Project Code\Imagenes_de_prueba\snap.jpg','jpg');
        %imwrite(frame,'snap.jpg','jpg');
        faceDetector = vision.CascadeObjectDetector;
        bboxes = faceDetector(frame);
        IFaces = insertObjectAnnotation(frame,'rectangle',bboxes,'Face'); 
        axes(handles.axes2);
        imshow(IFaces);  
    end

% Configurar la ventana de vista previa de video en tiempo real
preview(frontCam, hImage);
          
end

