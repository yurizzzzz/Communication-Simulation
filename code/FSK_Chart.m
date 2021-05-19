function [Output] = FSK_Chart(SNR,PERIOD)
i=10;
j=5000;
t=linspace(0,5,j);
f1=10;
fm=i/5;

error=0;

for echo=1:1:PERIOD  %一共循环echo个周期
%产生基带信号
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
st0=st1;
figure(1);
subplot(421);
plot(t,st0);
title('二进制基带信号');
axis([0,5,-1,2]);

%基带信号求反
st2=t;
for n=1:j
    if st1(n)==1
        st2(n)=0;
    else
        st2(n)=1;
    end
end
subplot(422);
plot(t,st2);
title('二进制基带信号反码');
axis([0,5,-1,2]);
 
%产生载波信号
s1=cos(2*pi*f1*t);
s2=cos(2*pi*f1*2*t);

 
%2FSK调制
F1=st1.*s1;
F2=st2.*s2;


e_fsk=F1+F2;
subplot(423);
plot(t,e_fsk);
title('2FSK信号');
 
%加入高斯白噪声;
fsk=awgn(e_fsk,SNR);%加入噪声
subplot(424);
plot(t,fsk);
title('加入噪声');

%带通滤波
[b1,a1]=butter(4,[0.07 0.13]);
fsk1=filter(b1,a1,fsk);
[b2,a2]=butter(4,[0.13 0.28]);
fsk2=filter(b2,a2,fsk);


st1=fsk1.*s1; %与载波1相乘

%低通滤波器
[f,sf1] = Florier(t,st1);
[t,st1] = LowPassFilter(f,sf1,2*fm);
subplot(425);
plot(t,st1);
title('低通1');

st2=fsk2.*s2;

%低通滤波器
[f,sf2] = Florier(t,st2);
[t,st2] = LowPassFilter(f,sf2,2*fm);
subplot(426);
plot(t,st2);
title('低通2');
 
%抽样判决
for m=0:i-1
    if st1(1,m*500+250)>st2(1,m*500+250)
        for j=m*500+1:(m+1)*500
            at(1,j)=1;
        end
    else
        for j=m*500+1:(m+1)*500
            at(1,j)=0;
        end
    end
end
for k=1:1:5000 
    if st0(k)~=at(k)
        error=error+1;
    end
end
subplot(427);
plot(t,at);
axis([0,5,-1,2]);
title('抽样判决后波形')
end
error_rate=error/500/(10*PERIOD);   %计算误码率
Output=error/500;
end

