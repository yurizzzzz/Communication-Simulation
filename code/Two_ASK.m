clear
clc

i=10;              %设置码元数为10个
j=5000;            %设置总共10个码元占用0-5共5000个点每个码元占用500个点
t=linspace(0,5,j); %t为时间轴分成了0-5共5000个点
fc=10;             %载波频率
B=2*i/5;
DB=10;             %选择添加信噪比的大小单位是dB

for echo=1:1:1     %一共循环echo个周期   
%产生二进制基带信号
x=(rand(1,i));
a=round(x);
st=t;
for n=1:10
    if a(n)<1
        for m=j/i*(n-1)+1:j/i*n  
            st(m)=0;
        end
    else
        for m=j/i*(n-1)+1:j/i*n
            st(m)=1;
        end
    end
end
figure(1);
subplot(421);
plot(t,st);
axis([0,5,-1,2]);
title('二进制基带信号');
%产生载波
s1=cos(2*pi*fc*t);
subplot(422);
plot(s1);
title('载波信号');
%2ASK调制
e_2ask=st.*s1;%st是基带信号,s1是载波
subplot(423);
plot(t,e_2ask);
title('调制信号2ASK');
%加入高斯白噪声;
e_2ask=awgn(e_2ask,DB);%加入噪声
subplot(424);
plot(t,e_2ask);
title('加入噪声的调制信号');
%带通滤波
[B,A]=butter(4,[0.06 0.14]);
bpf_2ask=filter(B,A,e_2ask);
at=bpf_2ask.*cos(2*pi*fc*t);
at=at-mean(at);
subplot(425);
plot(t,at);
title('载波相乘后信号');
%通过低通滤波器
[f,af] = Florier(t,at);
[t,at] = LowPassFilter(f,af,B);
subplot(426);
plot(t,at);
title('经过带通滤波器后的信号');
%抽样判决
for m=0:i-1 
    if (at(1,m*500+250)+0.5)<0.5
        for j=m*500+1:(m+1)*500
            at(1,j)=0;
        end
    else
        for j=m*500+1:(m+1)*500
            at(1,j)=1;
        end
    end
end

subplot(427);
plot(t,at);
axis([0,5,-1,2]);
title('抽样判决后波形')

end
