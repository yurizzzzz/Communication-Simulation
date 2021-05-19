function [Output] = PSK_Chart(SNR,PERIOD)
i=10;
j=5000;
t=linspace(0,5,j);
fc=10;
fm=i/5;
B=2*fm;
 
 
error=0;           %存取错误码元的个数
for echo=1:1:PERIOD  %一共循环echo个周期

a=round(rand(1,i));
st1=t;
for n=1:10
    if a(n)<1
        for m=j/i*(n-1)+1:j/i*n
            st1(m)=0;
        end
    else
        for m=j/i*(n-1)+1:j/i*n
            st1(m)=1;
        end
    end
end
figure(1);
subplot(421);
plot(t,st1);
title('二进制基带信号');
axis([0,5,-1,2]);
 
%二进制基带信号求反
st2=t;
for k=1:j
    if st1(k)>=1
        st2(k)=0;
    else
        st2(k)=1;
    end
end
 
st3=st1-st2;
subplot(422);
plot(t,st3);
title('双极性基带信号');
axis([0,5,-2,2]);
 
%产生载波信号
s1=sin(2*pi*fc*t);
subplot(423);
plot(s1);
title('载波信号');
 
%2PSK调制
e_psk=st3.*s1;

subplot(424);
plot(t,e_psk);
title('2PSK调制信号');
 
%高斯白噪声
psk=awgn(e_psk,SNR);
subplot(425);
plot(t,psk);
title('加噪后信号');

%带通滤波器
[b1,a1]=ellip(4,0.11,30,[9,11]*2/40);
psk=filter(b1,a1,psk);
 
psk=psk.*s1;
subplot(426);
plot(t,psk);
title('与载波相乘后信号');

[B,A]=butter(4,0.14);
psk=filter(B,A,psk);
subplot(427);
plot(t,psk);
title('低通滤波后');
 
%抽样判决
for m=0:i-1
    if psk(1,m*500+250)<0
        for j=m*500+1:(m+1)*500
            psk(1,j)=0;
        end
    else
        for j=m*500+1:(m+1)*500
            psk(1,j)=1;
        end
    end
end
for k=1:1:5000 
    if st1(k)~=psk(k)
        error=error+1;
    end
end
subplot(428);
plot(t,psk);
axis([0,5,-1,2]);
title('抽样判决后波形');
end
error_rate=error/500/(10*PERIOD);   %计算误码率
Output=error/500;
end

