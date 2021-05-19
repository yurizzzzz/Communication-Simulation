%=============Author:小范同学================%
%=======福州大学物理与信息工程学院===========%
%==============2020.06.06==================%
%=============通信原理课程设计==============%


function varargout = Login(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Login_OpeningFcn, ...
                   'gui_OutputFcn',  @Login_OutputFcn, ...
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


function Login_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);

global user_flag;
global lock_flag;
user_flag=0;
lock_flag=0;

user=imread('user.jpg');
user=imresize(user,[50,50],'bilinear');
set(handles.USER,'CDATA',user);
lock=imread('Lock.jpg');
lock=imresize(lock,[50,50],'bilinear');
set(handles.LOCK,'CDATA',lock);
login=imread('login.jpg');
set(handles.Login,'CDATA',login);

function varargout = Login_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function Login_Callback(hObject, eventdata, handles)
global user_flag;
global lock_flag;
if user_flag~=1 && lock_flag==1
    errordlg('请输入学号','提示','modal')
end
if user_flag==1 && lock_flag~=1
    errordlg('请输入密码','提示','modal')
end
if user_flag~=1 && lock_flag~=1
    errordlg('请输入学号和密码','提示','modal')
end
if user_flag==1 && lock_flag==1
    run('Serein.m');
    close(Login);
end


function figure1_CreateFcn(hObject, eventdata, handles)
Background=axes('units','normalized','pos',[0 0 1 1]);
uistack(Background,'down');
img=imread('Log.jpg');
image(img);
colormap gray
set(Background,'handlevisibility','off','visible','off');


function Login_CreateFcn(hObject, eventdata, handles)

%用户名输入
function UserInput_Callback(hObject, eventdata, handles)
global user_flag;
ID=get(hObject,'String');
if (str2num(ID)~=0)
    user_flag=1;
end


function UserInput_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function uipanel2_CreateFcn(hObject, eventdata, handles)

function axes1_CreateFcn(hObject, eventdata, handles)

function axes3_CreateFcn(hObject, eventdata, handles)


function LockInput_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%密码输入
function LockInput_Callback(hObject, eventdata, handles)
global lock_flag;
password=get(hObject,'String');
if (str2num(password)~=0)
    lock_flag=1;
end



function axes4_CreateFcn(hObject, eventdata, handles)

function axes5_CreateFcn(hObject, eventdata, handles)

function USER_Callback(hObject, eventdata, handles)

function LOCK_Callback(hObject, eventdata, handles)
