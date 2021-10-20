CantFrames=200;
VideoConSonido='Video.mp4';
VideoSinSonido='VideoModificado.mp4';
VideoLeido=vision.VideoFileReader(VideoConSonido,'AudioOutputPort',false);
NewVideo=vision.VideoFileWriter(VideoSinSonido,'AudioInputPort',false,'FileFormat','MPEG4');
BarraProgreso3 = waitbar(0,'Un Momento por favor se esta procesando el video..');
        for img = 1:CantFrames;
                waitbar(img/(CantFrames),BarraProgreso3);
                videoFrame = step(VideoLeido);
                step(NewVideo,videoFrame);
        end
close(BarraProgreso3)
release(hmfw);
release(hmfr);
helpdlg('Archivo Modificado Correctamente','Modificacion Exitosa');