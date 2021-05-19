clear
clc
%误码率数组初始化
ERROR_ASK=zeros(1,21);
ERROR_FSK=zeros(1,21);
ERROR_PSK=zeros(1,21);
ERROR_4PSK=zeros(1,21);

%信噪比范围
snr=-10;
snr_db=-10:1:10;
Snr=10.^(snr_db/10);

%每一个信噪比SNR对应的误码率
for loop=1:1:21
   ERROR_ASK(loop)=ASK_Function(snr);
   ERROR_FSK(loop)=FSK_Function(snr);
   ERROR_PSK(loop)=PSK_Function(snr);
   ERROR_4PSK(loop)=PSK4_Function(snr);
   snr=snr+1;
   disp(['当前进度为：',num2str(100/21*loop),'%'])
   if loop==21
       disp('已完成')
   end
end


%理论的误码率
Pe_2ASK_theory=0.5*erfc(sqrt(0.25*Snr));      %理论误码率计算
semilogy(snr_db,Pe_2ASK_theory,'r-');hold on; %绘制理论误码率曲线
Pe_2FSK_theory=0.5*erfc(sqrt(0.5*Snr));       %理论误码率计算
semilogy(snr_db,Pe_2FSK_theory,'g-');hold on; %绘制理论误码率曲线
Pe_2PSK_theory=0.5*erfc(sqrt(Snr));
semilogy(snr_db,Pe_2PSK_theory,'b-');hold on; %绘制理论误码率曲线
Pe_4PSK_theory=0.5*erfc(sqrt(Snr*0.5));
semilogy(snr_db,Pe_4PSK_theory,'y-');hold on;



%实际误码率
semilogy(snr_db,ERROR_ASK,'r*');hold on;      %绘制实际误码率
semilogy(snr_db,ERROR_FSK,'g*');hold on;      %绘制实际误码率
semilogy(snr_db,ERROR_PSK,'b*');hold on;      %绘制实际误码率
semilogy(snr_db,ERROR_4PSK,'y*');hold on;

grid on;
legend('ERROR_ASK','ERROR_FSK','ERROR_PSK','ERROR_4PSK','Pe_2ASK_theory','Pe_2FSK_theory','Pe_2PSK_theory','Pe_4PSK_theory');
xlabel('信噪比/dB');
ylabel('误码率');