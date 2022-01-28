function varargout = deBlurring(varargin)
% DEBLURRING MATLAB code for deBlurring.fig
%      DEBLURRING, by itself, creates a new DEBLURRING or raises the existing
%      singleton*.
%
%      H = DEBLURRING returns the handle to a new DEBLURRING or the handle to
%      the existing singleton*.
%
%      DEBLURRING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEBLURRING.M with the given input arguments.
%
%      DEBLURRING('Property','Value',...) creates a new DEBLURRING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before deBlurring_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to deBlurring_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help deBlurring

% Last Modified by GUIDE v2.5 09-Jan-2022 17:37:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @deBlurring_OpeningFcn, ...
                   'gui_OutputFcn',  @deBlurring_OutputFcn, ...
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


% --- Executes just before deBlurring is made visible.
function deBlurring_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to deBlurring (see VARARGIN)

% Choose default command line output for deBlurring
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes deBlurring wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = deBlurring_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[a,b]=uigetfile('*.*');
a=imread(fullfile(b,a));
axes(handles.axes5);
imshow(a);
setappdata(0,'a',a);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
PSF = fspecial('motion',21,11);
Idouble = im2double(a);
blurred = imfilter(Idouble,PSF,'conv','circular');
setGlobalx(blurred);
axes(handles.axes6);
imshow(blurred)

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
blurred = getGlobalx;
noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(blurred,'gaussian',noise_mean,noise_var);
setGlobalx2(blurred_noisy);
axes(handles.axes8);
imshow(blurred_noisy)

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
blurImg = getGlobalx;
PSF = fspecial('motion',21,11);
wnr1 = deconvwnr(blurImg,PSF);
axes(handles.axes7);
imshow(wnr1)

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
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

function setGlobalx2(val)
global x
x = val;

function r = getGlobalx2
global x
r = x;


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
Idouble = im2double(a);
noise_var = 0.0001;
blurred_noisy = getGlobalx2;
signal_var = var(Idouble(:));
NSR = noise_var / signal_var;
PSF = fspecial('motion',21,11);
wnr3 = deconvwnr(blurred_noisy,PSF,NSR);
axes(handles.axes9);
imshow(wnr3)
