function varargout = saltPepper(varargin)
% SALTPEPPER MATLAB code for saltPepper.fig
%      SALTPEPPER, by itself, creates a new SALTPEPPER or raises the existing
%      singleton*.
%
%      H = SALTPEPPER returns the handle to a new SALTPEPPER or the handle to
%      the existing singleton*.
%
%      SALTPEPPER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SALTPEPPER.M with the given input arguments.
%
%      SALTPEPPER('Property','Value',...) creates a new SALTPEPPER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saltPepper_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saltPepper_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help saltPepper

% Last Modified by GUIDE v2.5 09-Jan-2022 16:19:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @saltPepper_OpeningFcn, ...
                   'gui_OutputFcn',  @saltPepper_OutputFcn, ...
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


% --- Executes just before saltPepper is made visible.
function saltPepper_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to saltPepper (see VARARGIN)

% Choose default command line output for saltPepper
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes saltPepper wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = saltPepper_OutputFcn(hObject, eventdata, handles) 
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
salt=imnoise(a,'salt & pepper',0.02);
setGlobalx(salt);
axes(handles.axes2);
imshow(salt);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
noisyimg = getGlobalx;
resImg = medfilt2(noisyimg);
axes(handles.axes3);
imshow(resImg);

function setGlobalx(val)
global x
x = val;

function r = getGlobalx
global x
r = x;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
noisyimg = getGlobalx;
resImg = filter2(fspecial('average',3),noisyimg)/255;
axes(handles.axes4);
imshow(resImg);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
home
closereq;
