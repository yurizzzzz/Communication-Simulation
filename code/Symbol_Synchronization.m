clear
clc
i=10;
j=5000;
t=linspace(0,5,j);
fc=10;
fm=i/5;
B=2*fm;
 
DB=10;              %选择添加信噪比的大小单位是dB

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
st2=t;
for k=1:j
    if st1(k)>=1
        st2(k)=0;
    else
        st2(k)=1;
    end
end

st3=st1-st2;

s1=sin(2*pi*fc*t);

e_psk=st3.*s1;

psk=awgn(e_psk,DB);

[b1,a1]=ellip(4,0.1,40,[999.9,1000.1]*2/5000);
psk=filter(b1,a1,psk);

psk=psk.*s1;
[f,af] = Florier(t,psk);
[t,psk] = LowPassFilter(f,af,B);




receive=psk;
figure(1)
subplot(321);
plot(t,receive);
title('低通滤波后接收端信号');
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

for count=1:j
    if receive(count)>0
        receive(count)=1;
    end
    if receive(count)<0
        receive(count)=0;
    end
end


subplot(322)
plot(t,receive)
axis([0,5,-2,2]);
title('放大限幅后的信号')
psk=receive;


N=length(psk);
y=zeros(1,N);
for n=1:(N-1)
    y(n) = psk(n+1) -psk(n);
end
y(N)=psk(N);

signal_rectified = abs(y);
subplot(323)
plot(t,signal_rectified)
title('微分整流')
axis([0,5,-2,2]);

w = (0:(j-1))*500*2*pi/j;
signal_fft = fft(signal_rectified);
wl = 2*pi*0.999; wh = 2*pi*1.0001;
band_filter = stepfun(w,wl) - stepfun(w,wh);
signal_bf = signal_fft .* band_filter;
codeclock = ifft(signal_bf); 
codeclock = real(codeclock);
subplot(324)
plot(t,codeclock)
title('窄带滤波')
axis([0,5,-2e-3,2e-3]);


BitSynch_rz = codeclock;
N = length(BitSynch_rz);
result = zeros(1,N);
for n = 1:N
    if (BitSynch_rz(n)==min(codeclock(1:500))) || (BitSynch_rz(n)==min(codeclock(500:1000)))
        result(n) = 1;
    else
        result(n) = 0;
    end
end 
subplot(325)
plot(t,result)
title('位定时脉冲')
axis([0,5,-2,2]);
end




