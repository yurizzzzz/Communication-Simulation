i=10;
j=5000;
t=linspace(0,5,j);
fc=10;
fm=i/5;
B=2*fm;
 

DB=10;              %选择添加信噪比的大小单位是dB

error=0;           %存取错误码元的个数
for echo=1:1:1  %一共循环echo个周期

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
subplot(411);
plot(t,st1);
title('基带信号st1');
axis([0,5,-1,2]);
 
%基带信号求反
st2=t;
for k=1:j
    if st1(k)>=1
        st2(k)=0;
    else
        st2(k)=1;
    end
end
subplot(412);
plot(t,st2);
title('基带信号反码');
axis([0,5,-1,2]);
 
st3=st1-st2;
subplot(413);
plot(t,st3);
title('双极性基带信号');
axis([0,5,-2,2]);
 
%载波信号
s1=sin(2*pi*fc*t);
subplot(414);
plot(s1);
title('载波信号');
%2PSK调制
e_psk=st3.*s1;
figure(2);
subplot(511);
plot(t,e_psk);
title('调制后波形2psk');
 
%加噪
psk=awgn(e_psk,DB);%加入噪声
subplot(512);
plot(t,psk);
title('加噪后波形');

%带通滤波器
[b1,a1]=ellip(4,0.1,40,[999.9,1000.1]*2/5000);
psk=filter(b1,a1,psk);

psk=psk.*s1;%与载波相乘
subplot(513);
plot(t,psk);
title('与载波相乘后波形');
[f,af] = Florier(t,psk);%傅里叶变换
[t,psk] = LowPassFilter(f,af,B);%通过低通滤波器
subplot(514);
plot(t,psk);
title('低通滤波后波形');
 
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
subplot(515);
plot(t,psk);
axis([0,5,-1,2]);
title('抽样判决后波形');
end