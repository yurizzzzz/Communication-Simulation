# Communication System Simulation

## 项目说明
本项目是福州大学《通信原理课程设计》的题目，本项目具体实现内容如下
- 基于Matlab的2ASK，2FSK，2PSK，4PSK系统的调制解调的基本仿真实现
- 实现2ASK，2FSK，2PSK，4PSK系统的误码率分析
- 2PSK的载波提取（科斯塔斯环方法）
- 位同步信号提取（微分整流滤波法）
- 基于Matlab的一个GUI用户交互界面设计，此GUI界面分为两个部分，第一个是用户登陆界面第二个部分 是通信系统仿真界面，仿真界面中提供了信噪比选择，周期输入等交互选项

## 文件说明
```
|-- README.md
|-- code
|   |-- ASK_Chart.m        绘制ASK调制解调曲线图
|   |-- ASK_Function.m     ASK调制解调函数用于GUI中调用
|   |-- Background.png     背景图
|   |-- Costas_2PSK.m      科斯塔斯环
|   |-- Error_Chart.m      绘制误码率曲线
|   |-- FSK_Chart.m        绘制ASK调制解调曲线图
|   |-- FSK_Function.m     FSK调制解调函数用于GUI中调用
|   |-- Florier.m          傅里叶函数
|   |-- Four_PSK.m         4PSK函数
|   |-- Lock.jpg           登陆界面中的图标
|   |-- Log.jpg            登陆界面中的图标
|   |-- Login.fig          登陆界面GUI
|   |-- Login.m            登陆界面GUI的各个回调函数
|   |-- LowPassFilter.m    低通滤波器函数
|   |-- PSK4_Chart.m       绘制4PSK曲线图
|   |-- PSK4_Function.m    4PSK函数用于GUI中调用
|   |-- PSK_Chart.m        绘制PSK曲线图
|   |-- PSK_Function.m     PSK函数用于GUI中调用
|   |-- Serein.fig         功能界面GUI
|   |-- Serein.m           功能界面GUI的各个回调函数
|   |-- Symbol_Synchronization.m     
|   |-- Two_ASK.m          2ASK，非函数，可直接运行
|   |-- Two_FSK.m          2FSK，非函数，可直接运行
|   |-- Two_PSK.m          2PSK，非函数，可直接运行
|   |-- login.jpg          登陆界面中的图标
|   |-- user.jpg           登陆界面中的图标
|-- exe
|   |-- ZY.exe             GUI的可执行程序，运行前需确定安装MCR插件（Matlab的一个插件）
|   |-- mccExcludedFiles.log   无用
|   |-- readme.txt             无用
|   |-- requiredMCRProducts.txt  无用
```

## 运行环境
- Matlab R2018a
- Matlab Runtime 9.4
- Windows10

## 效果
**主界面**  
![主界面](https://www.hualigs.cn/image/60a4d97e5fcf8.jpg)  
**登录界面**  
![登陆界面](https://www.hualigs.cn/image/60a4d9d585d13.jpg)
