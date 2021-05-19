function [output] = PSK_Function(db)
i=10;
j=5000;
t=linspace(0,5,j);
fc=10;
fm=i/5;
B=2*fm;

error=0;           %存取错误码元的个数
for echo=1:1:1000  %一共循环echo个周期

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


psk=awgn(e_psk,db);

[b1,a1]=ellip(4,0.11,30,[9,11]*2/40);
psk=filter(b1,a1,psk);

psk=psk.*s1;

[B,A]=butter(4,0.12);
psk=filter(B,A,psk);

 
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

end
error_rate=error/500/10000;   %计算误码率
if error_rate==0
    error_rate=0.00006;
end
output=error_rate;


end

