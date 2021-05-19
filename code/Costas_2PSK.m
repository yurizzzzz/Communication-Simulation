function [Output1,Output2] = Costas_2PSK()

i=10;
num=5000;
t=linspace(0,5,num);
fc =0.1e6;
fm=i/5;
B=2*fm;

fs =50e6;
Ts = 1/fs;
ps = 1e6;

a=round(rand(1,i));
st1=t;
for n=1:10
    if a(n)<1
        for m=num/i*(n-1)+1:num/i*n
            st1(m)=0;
        end
    else
        for m=num/i*(n-1)+1:num/i*n
            st1(m)=1;
        end
    end
end
 
st2=t;
for k=1:num
    if st1(k)>=1
        st2(k)=0;
    else
        st2(k)=1;
    end
end

st3=st1-st2;
s1=sin(2*pi*fc*t);

e_psk=st3.*s1;


Ac =1;                                
Delta_Phase=rand(1)*2*pi;               %随机初相，rad 
ss1 = Ac*cos(2*pi*(fc)*t+Delta_Phase);     %--构造同相载波信号
ss2 = Ac*sin(2*pi*(fc)*t+Delta_Phase);    %--构造正交载波信号

ss1_psk=e_psk.*ss1;
ss2_psk=e_psk.*ss2;


Signal_Channel = ss1_psk + 1i * ss2_psk;%用复信号形式表示
T=1/(fc*10);
Simulation_Length = 200;
Sample_Length = length(t);
decimator = 1;
symbol_rate = ps;
I_data1 = e_psk;
Q_data1 = zeros(1,length(t));

%锁相环参数清零和初始化
Signal_PLL=zeros(1,Sample_Length);
I_PLL=zeros(1,Sample_Length);
Q_PLL=zeros(1,Sample_Length);
NCO_Phase = zeros(1,Sample_Length);
Discriminator_Out=zeros(1,Sample_Length);
Freq_Control=zeros(1,Sample_Length);
PLL_Phase_Part=zeros(1,Sample_Length);
PLL_Freq_Part=zeros(1,Sample_Length);

Ko=1;                                       
Kd=1;                          
K=Ko*Kd;                       
sigma=0.707;                   
BL=0.98*symbol_rate;           
Wn=8*sigma*BL/(1+4*sigma^2);    
T_nco=Ts*decimator;             
K1=(2*sigma*Wn*T_nco)/(K);    
K2=((T_nco*Wn)^2)/(K);         




for i=2:Sample_Length
        Signal_PLL(i)=Signal_Channel(i)*exp(-1i*mod(NCO_Phase(i-1),2*pi));  
        I_PLL(i)=real(Signal_PLL(i));                                     
        Q_PLL(i)=imag(Signal_PLL(i));                                      
        
        
        Discriminator_Out(i)=sign(I_PLL(i))*Q_PLL(i)/abs(Signal_PLL(i));   
        PLL_Phase_Part(i)=Discriminator_Out(i)*K1;                        
        Freq_Control(i)=PLL_Phase_Part(i)+PLL_Freq_Part(i-1);             
        PLL_Freq_Part(i)=Discriminator_Out(i)*K2+PLL_Freq_Part(i-1);      
        NCO_Phase(i)=NCO_Phase(i-1)+Freq_Control(i);                       
end


Output1=cos(NCO_Phase);
Output2=ss1;

figure(1)

plot(cos(NCO_Phase),'r');grid on        %锁相环提取的载波
hold on;
axis([0 500 -2 2]);
title('锁相环提取的载波');


plot(ss1)                                %发射载波
hold on;
axis([0 500 -2 2]);
title('原来构造的同相载波');

end

