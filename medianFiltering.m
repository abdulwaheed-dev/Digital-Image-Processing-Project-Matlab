function varargout = medianFiltering(varargin)
% MEDIANFILTERING MATLAB code for medianFiltering.fig
%      MEDIANFILTERING, by itself, creates a new MEDIANFILTERING or raises the existing
%      singleton*.
%
%      H = MEDIANFILTERING returns the handle to a new MEDIANFILTERING or the handle to
%      the existing singleton*.
%
%      MEDIANFILTERING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MEDIANFILTERING.M with the given input arguments.
%
%      MEDIANFILTERING('Property','Value',...) creates a new MEDIANFILTERING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before medianFiltering_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to medianFiltering_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help medianFiltering

% Last Modified by GUIDE v2.5 10-Jan-2022 12:51:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @medianFiltering_OpeningFcn, ...
                   'gui_OutputFcn',  @medianFiltering_OutputFcn, ...
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


% --- Executes just before medianFiltering is made visible.
function medianFiltering_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to medianFiltering (see VARARGIN)

% Choose default command line output for medianFiltering
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes medianFiltering wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = medianFiltering_OutputFcn(hObject, eventdata, handles) 
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
salt=imnoise(a,'salt & pepper',0.4);
setGlobalx(salt);
axes(handles.axes2);
imshow(salt);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sp_cktb = getGlobalx;
mask_size = 7;
med_filter = @(mask) median(mask(:));
med_cktb = nlfilter(sp_cktb,[mask_size,mask_size],med_filter);
axes(handles.axes3);
imshow(med_cktb,[]);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sp_cktb = getGlobalx;
init_mask_size = 3;
max_mask_size = 7;
adap_med_cktb = adap_med_filter(sp_cktb,init_mask_size,max_mask_size);
axes(handles.axes4);
imshow(adap_med_cktb,[]);

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
