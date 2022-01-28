function varargout = gaussian(varargin)
% GAUSSIAN MATLAB code for gaussian.fig
%      GAUSSIAN, by itself, creates a new GAUSSIAN or raises the existing
%      singleton*.
%
%      H = GAUSSIAN returns the handle to a new GAUSSIAN or the handle to
%      the existing singleton*.
%
%      GAUSSIAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAUSSIAN.M with the given input arguments.
%
%      GAUSSIAN('Property','Value',...) creates a new GAUSSIAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gaussian_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gaussian_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gaussian

% Last Modified by GUIDE v2.5 09-Jan-2022 18:27:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gaussian_OpeningFcn, ...
                   'gui_OutputFcn',  @gaussian_OutputFcn, ...
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


% --- Executes just before gaussian is made visible.
function gaussian_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gaussian (see VARARGIN)

% Choose default command line output for gaussian
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gaussian wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gaussian_OutputFcn(hObject, eventdata, handles) 
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
[a,b]=uigetfile('*.*');
a=imread(fullfile(b,a));
axes(handles.axes1);
imshow(a);
setappdata(0,'a',a);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
gau=imnoise(a,'gaussian',0,0.01); %Gassian Noise with mean 0 and vaiance 0.02
setGlobalx(gau);
axes(handles.axes2);
imshow(gau);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
noisyImage = getGlobalx;
h=fspecial('average',3);
denoisedImage = imfilter(noisyImage,h);
axes(handles.axes3);
imshow(denoisedImage);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
noisyImage=getGlobalx;
kr=3;
kc=3;
g=im2double(noisyImage);
f=exp(imfilter(log(g),ones(kr,kc),'replicate')).^(1/(kr*kc));
axes(handles.axes4);
imshow(f);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
home
closereq;

function setGlobalx(val)
global x
x = val;

function r = getGlobalx
global x
r = x;
