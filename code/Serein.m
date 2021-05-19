%=============Author:小范同学================%
%=======福州大学物理与信息工程学院===========%
%==============2020.06.06==================%
%=============通信原理课程设计==============%



function varargout = Serein(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Serein_OpeningFcn, ...
                   'gui_OutputFcn',  @Serein_OutputFcn, ...
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

function Serein_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);
global snr;
global period;
global method1;
global method2;
method1 =1;
method2=1;
snr=1;
period='0';


function varargout = Serein_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function figure1_CreateFcn(hObject, eventdata, handles)
Background=axes('units','normalized','pos',[0 0 1 1]);
uistack(Background,'down');
img=imread('Background.png');
image(img);
colormap gray
set(Background,'handlevisibility','off','visible','off');


%2ASK调制解调按钮
function ASKbutton_Callback(hObject, eventdata, handles)
global snr;
global period;
SNR_List=-10:1:10;
if snr==1 && (str2num(period)==0)
    errordlg('请选择参数','提示','modal')
end

if snr==1 && (str2num(period)>1)
    set(handles.text1,'String','请选择信噪比')
    errordlg('请选择信噪比值','提示','modal')
end
if (str2num(period)==0 || str2num(period)<1) && snr~=1
    set(handles.text1,'String','请输入周期数')
    errordlg('请输入正确的周期数','提示','modal')
end

if snr~=1 && (str2num(period)>0)
    Error=ASK_Chart(SNR_List(snr-1),str2num(period));
    set(handles.text1,'String',['误码个数：',num2str(Error),'个']);
end

%选择信噪比弹出式菜单
function SNR_Callback(hObject, eventdata, handles)
global snr;
snr=get(hObject,'Value');

function SNR_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%2FSK调制解调按钮
function FSKbutton_Callback(hObject, eventdata, handles)
global snr;
global period;

SNR_List=-10:1:10;
if snr==1 && (str2num(period)==0)
    errordlg('请选择参数','提示','modal')
end

if snr==1 && (str2num(period)>1)
    set(handles.text1,'String','请选择信噪比')
    errordlg('请选择信噪比值','提示','modal')
end
if (str2num(period)==0 || str2num(period)<1) && snr~=1
    set(handles.text1,'String','请输入周期数')
    errordlg('请输入正确的周期数','提示','modal')
end

if snr~=1 && (str2num(period)>0)
    Error=FSK_Chart(SNR_List(snr-1),str2num(period));
    set(handles.text1,'String',['误码个数：',num2str(Error),'个']);
end

%2PSK调制解调按钮
function PSKbutton_Callback(hObject, eventdata, handles)
global snr;
global period;

SNR_List=-10:1:10;
if snr==1 && (str2num(period)==0)
    errordlg('请选择参数','提示','modal')
end

if snr==1 && (str2num(period)>1)
    set(handles.text1,'String','请选择信噪比')
    errordlg('请选择信噪比值','提示','modal')
end
if (str2num(period)==0 || str2num(period)<1) && snr~=1
    set(handles.text1,'String','请输入周期数')
    errordlg('请输入正确的周期数','提示','modal')
end

if snr~=1 && (str2num(period)>0)
    Error=PSK_Chart(SNR_List(snr-1),str2num(period));
    set(handles.text1,'String',['误码个数：',num2str(Error),'个']);
end

%4PSK调制解调按钮
function QPSKbutton_Callback(hObject, eventdata, handles)
global snr;
global period;

SNR_List=-10:1:10;
if snr==1 && (str2num(period)==0)
    errordlg('请选择参数','提示','modal')
end

if snr==1 && (str2num(period)>1)
    set(handles.text1,'String','请选择信噪比')
    errordlg('请选择信噪比值','提示','modal')
end
if (str2num(period)==0 || str2num(period)<1) && snr~=1
    set(handles.text1,'String','请输入周期数')
    errordlg('请输入正确的周期数','提示','modal')
end

if snr~=1 && (str2num(period)>0)
    Error=PSK4_Chart(SNR_List(snr-1),str2num(period));
    set(handles.text1,'String',['误码个数：',num2str(Error),'个']);
end

%选择周期的输入式动态框
function Echo_Edit_Callback(hObject, eventdata, handles)
global period;
period=get(hObject,'String');

function Echo_Edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%2ASK误码率绘制按钮
function Error_2ASK_Callback(hObject, eventdata, handles)
errordlg('正在运行可能需要一些时间请稍等','提示','modal');
ERROR_ASK=zeros(1,11);
SNR=-10;
snr_db=-10:2:10;
Snr=10.^(snr_db/10);
set(handles.text2,'String','2ASK');
for loop=1:1:11
   ERROR_ASK(loop)=ASK_Function(SNR);
   SNR=SNR+2;
   errordlg(['当前进度为',num2str(100/11*loop),'%'],'提示','modal');
   if loop==11
      set(handles.text3,'String','已完成100%');
   end
end
axes(handles.axes4);
cla;
Pe_2ASK_theory=0.5*erfc(sqrt(0.45*Snr));      
semilogy(snr_db,Pe_2ASK_theory,'r-');hold on; 
semilogy(snr_db,ERROR_ASK,'r--');    
grid on;
legend('TheoryError','ActualError');
xlabel('信噪比/dB');
ylabel('误码率');

%2FSK误码率绘制按钮
function Error_2FSK_Callback(hObject, eventdata, handles)
errordlg('正在运行可能需要一些时间请稍等','提示','modal');
ERROR_FSK=zeros(1,11);
SNR=-10;
snr_db=-10:2:10;
Snr=10.^(snr_db/10);
set(handles.text2,'String','2FSK');
for loop=1:1:11
   ERROR_FSK(loop)=FSK_Function(SNR);
   SNR=SNR+2;
   errordlg(['当前进度为',num2str(100/11*loop),'%'],'提示','modal');
   if loop==11
      set(handles.text3,'String','已完成100%');
   end
end
axes(handles.axes4);
cla;
Pe_2FSK_theory=0.5*erfc(sqrt(0.6*Snr));      
semilogy(snr_db,Pe_2FSK_theory,'g-');hold on; 
semilogy(snr_db,ERROR_FSK,'g--');      
grid on;
legend('TheoryError','ActualError');
xlabel('信噪比/dB');
ylabel('误码率');

%2PSK误码率绘制按钮
function Error_2PSK_Callback(hObject, eventdata, handles)
errordlg('正在运行可能需要一些时间请稍等','提示','modal');
ERROR_PSK=zeros(1,11);
SNR=-10;
snr_db=-10:2:10;
Snr=10.^(snr_db/10);
set(handles.text2,'String','2PSK');
for loop=1:1:11
   ERROR_PSK(loop)=PSK_Function(SNR);
   SNR=SNR+2;
   errordlg(['当前进度为',num2str(100/11*loop),'%'],'提示','modal');
   if loop==11
      set(handles.text3,'String','已完成100%');
   end
end
axes(handles.axes4);
cla;
Pe_2PSK_theory=0.5*erfc(sqrt(Snr));
semilogy(snr_db,Pe_2PSK_theory,'b-');hold on; 
semilogy(snr_db,ERROR_PSK,'b--');      
grid on;
legend('TheoryError','ActualError');
xlabel('信噪比/dB');
ylabel('误码率');

%4PSK误码率绘制按钮
function Error_4PSK_Callback(hObject, eventdata, handles)
errordlg('正在运行可能需要一些时间请稍等','提示','modal');
ERROR_4PSK=zeros(1,11);
SNR=-10;
snr_db=-10:2:10;
Snr=10.^(snr_db/10);
set(handles.text2,'String','2PSK');
for loop=1:1:11
   ERROR_4PSK(loop)=PSK4_Function(SNR);
   SNR=SNR+2;
   errordlg(['当前进度为',num2str(100/11*loop),'%'],'提示','modal');
   if loop==11
      set(handles.text3,'String','已完成100%');
   end
end
axes(handles.axes4);
cla;
Pe_4PSK_theory=0.5*erfc(sqrt(Snr));
semilogy(snr_db,Pe_4PSK_theory,'k-');hold on;
semilogy(snr_db,ERROR_4PSK,'k--');   
axis([-10 10 10^(-5) 1e0]);
grid on;
legend('TheoryError','ActualError');
xlabel('信噪比/dB');
ylabel('误码率');

%坐标轴显示
function axes4_CreateFcn(hObject, eventdata, handles)

function clear_Callback(hObject, eventdata, handles)
cla(handles.axes4);

%科斯塔斯环载波提取按钮
function Costasbutton_Callback(hObject, eventdata, handles)
cla
global method1;
if method1==2
[OUT1,OUT2]=Costas_2PSK();
%{
axes(handles.axes4);

plot(OUT1,'r');
axis([0 500 -2 2]);
grid on     
hold on;


plot(OUT2,'g');
axis([0 500 -2 2]);
grid on;                                %发射载波

hold on;
legend('提取的载波','原来构造的载波');
%}
else
    errordlg('请选择载波提取方法','提示','modal');
end


%载波提取方法选择
function Method_Callback(hObject, eventdata, handles)

global method1;
method1=get(hObject,'Value');

function Method_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%退出系统按钮
function EXIT_Callback(hObject, eventdata, handles)
close(Serein);

%位同步按钮
function Synchronizationbutton_Callback(hObject, eventdata, handles)
global method2;
if method2==2
run('Symbol_Synchronization.m')
else
    errordlg('请选择位同步方法','提示','modal');
end

%位同步方法选择
function methodMenu_Callback(hObject, eventdata, handles)
global method2;
method2=get(hObject,'Value');


function methodMenu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
