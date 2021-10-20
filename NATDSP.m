function varargout = NATDSP(varargin)
% NATDSP MATLAB code for NATDSP.fig
%      NATDSP, by itself, creates a new NATDSP or raises the existing
%      singleton*.
%
%      H = NATDSP returns the handle to a new NATDSP or the handle to
%      the existing singleton*.
%
%      NATDSP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NATDSP.M with the given input arguments.
%
%      NATDSP('Property','Value',...) creates a new NATDSP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NATDSP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NATDSP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NATDSP

% Last Modified by GUIDE v2.5 22-Oct-2019 13:17:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NATDSP_OpeningFcn, ...
                   'gui_OutputFcn',  @NATDSP_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before NATDSP is made visible.
function NATDSP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NATDSP (see VARARGIN)

% Choose default command line output for NATDSP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NATDSP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NATDSP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global frontCam
set(handles.axes3);      
axes(handles.axes3);
frontCam = videoinput('winvideo', 1,'YUY2_640x480');
set(frontCam,'TriggerRepeat',inf);
set(frontCam,'FramesPerTrigger',1);
set(frontCam,'ReturnedColorSpace','rgb');
vidRes=get(frontCam,'VideoResolution');
nBands=get(frontCam,'NumberOfBands');
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
preview(frontCam, hImage);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 disp('RECONOCIMIENTO EXPRESIONES FACIALES')
 
TrainImagePath = 'C:\Users\samuel\Desktop\RECONOCIMIENTO_EXPRECIONES_FACIALES\Project Code\BASE_DATOS';
TestImagePath = 'C:\Users\samuel\Desktop\RECONOCIMIENTO_EXPRECIONES_FACIALES\Project Code\Imagenes_de_prueba';
LabelPath = 'C:\Users\samuel\Desktop\RECONOCIMIENTO_EXPRECIONES_FACIALES\Project Code\ETIQUETAS_IMAGENES.txt';

[NumTrainImg,TrainImg] = loadImage( TrainImagePath );
[NumTestImg,TestImg] = loadImage( TestImagePath );

[C,minDist,minDistIndex] = eigenFaceRecognition(TrainImg,TestImg,NumTrainImg,NumTestImg );

% Display the result
RecognizedExpression = strcat(int2str(minDistIndex),'.jpg')
    % read in the image label
    fid=fopen(LabelPath);
    imageLabel=textscan(fid,'%s %s','whitespace',',');
    fclose(fid);

    % export the matched label
    Best_Match = cell2mat(imageLabel{1,1}(minDistIndex));
    ExprLabel = cell2mat(imageLabel{1,2}(minDistIndex))

%str1 = strcat('Your face expression is like this one:  ',RecognizedExpression);
str2 = strcat('PODEMOS DECIR QUE TE ENCUENTRAS:  ',ExprLabel);
%disp(str1)
set(handles.text2,'String',str2);
disp(str2)
              
% --- Executes during object creation, after setting all properties.
function dsp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dsp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function dsp_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to dsp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global frontCam
  frame = getsnapshot(frontCam);
  frame=frame;
  imwrite(frame,'C:\Users\samuel\Desktop\RECONOCIMIENTO_EXPRECIONES_FACIALES\Project Code\Imagenes_de_prueba\snap.jpg','jpg');
  set(handles.axes2);      
  axes(handles.axes2);
  faceDetector = vision.CascadeObjectDetector;
  bboxes = faceDetector(frame);
  IFaces = insertObjectAnnotation(frame,'rectangle',bboxes,'Face'); 
  axes(handles.axes2);
  imshow(IFaces);  


