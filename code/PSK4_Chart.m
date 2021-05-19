function [Output] = PSK4_Chart(SNR,PERIOD)
i=10;
j=5000;
t=linspace(0,5,j);
fc=10;
fm=i/5;
B=2*fm;


for encho=1:1:PERIOD
error=0;           
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
subplot(421)
plot(t,st1);
title('基带信号');
axis([0,5,-2,2]);

data=t;
for k=0:2:8
    if (st1(k*500+250)==0 && st1((k+1)*500+250)==0)
        for count=j/i*k+1:j/i*(k+2)
            data(count)=cos(2*pi*fc*t(count)+0.5*pi);
        end
    end
    if (st1(k*500+250)==0 && st1((k+1)*500+250)==1)
        for count=j/i*k+1:j/i*(k+2)
            data(count)=cos(2*pi*fc*t(count)+0*pi);
        end
    end
    if (st1(k*500+250)==1 && st1((k+1)*500+250)==0)
        for count=j/i*k+1:j/i*(k+2)
            data(count)=cos(2*pi*fc*t(count)+pi);
        end
    end        
    if (st1(k*500+250)==1 && st1((k+1)*500+250)==1)
        for count=j/i*k+1:j/i*(k+2)
            data(count)=cos(2*pi*fc*t(count)+1.5*pi);
        end
    end              
end
subplot(422)
plot(t,data);
title('4PSK调制信号');
axis([0,5,-2,2]);


data=awgn(data,SNR);%加入噪声
subplot(423)
plot(t,data);
title('加入噪声后信号');
axis([0,5,-2,2]);

data1=data.*cos(2*pi*fc*t);%与载波相乘
subplot(424)
plot(t,data1);
title('载波cos相乘');
axis([0,5,-2,2]);

data2=-data.*sin(2*pi*fc*t);%与载波相乘
subplot(425)
plot(t,data2);
title('载波-sin相乘'); 
axis([0,5,-2,2]);

%[f1,af1] = Florier(t,data1);%傅里叶变换
%[t,data1] = LowPassFilter(f1,af1,B);%通过低通滤波器
[B1,A1]=butter(4,0.03);
data1=filter(B1,A1,data1);
subplot(426)
plot(t,data1);
title('低通滤波1');

%[f2,af2] = Florier(t,data2);%傅里叶变换
%[t,data2] = LowPassFilter(f2,af2,B);%通过低通滤波器
[B2,A2]=butter(4,0.008);
data2=filter(B2,A2,data2);
subplot(427)
plot(t,data2);
title('低通滤波2');

for m=1:2:i-1
    if (data1(1,m*500)<0.3 && data1(1,m*500)>-0.3) && (data2(1,m*500)<-0.25)
        for j=(m-1)*500+1:m*500
            data(1,j)=1;
        end
        for j=m*500+1:(m+1)*500
            data(1,j)=1;
        end 
     
    elseif (data2(1,m*500)<0.3 && data2(1,m*500)>-0.3) && (data1(1,m*500)<-0.25)
        for j=(m-1)*500+1:m*500
            data(1,j)=1;
        end
        for j=m*500+1:(m+1)*500
            data(1,j)=0;
        end 
     
    elseif (data2(1,m*500)<0.3 && data2(1,m*500)>-0.3) && (data1(1,m*500)>0.25)
        for j=(m-1)*500+1:m*500
            data(1,j)=0;
        end
        for j=m*500+1:(m+1)*500
            data(1,j)=1;
        end 
             
    elseif (data1(1,m*500)<0.3 && data1(1,m*500)>-0.3) && (data2(1,m*500)>0.25)
        for j=(m-1)*500+1:m*500
            data(1,j)=0;
        end
        for j=m*500+1:(m+1)*500
            data(1,j)=0;
        end 
    else
        for j=(m-1)*500+1:m*500
            data(1,j)=0;
        end
        for j=m*500+1:(m+1)*500
            data(1,j)=0;
        end  
    end
end

for k=1:1:5000 
    if data(k)~=st1(k)
        error=error+1;
    end
end

subplot(428);
plot(t,data);
title('抽样判决后');
axis([0,5,-2,2]);

end
error_rate=error/500/(10*PERIOD);   %计算误码率
Output=error;

end

