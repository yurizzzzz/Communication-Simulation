function [t,st]=LowPassFilter(f,sf,B)
df = f(2)-f(1);
T = 1/df;
hf = zeros(1,length(f));
bf = [-floor( B/df ): floor( B/df )] + floor( length(f)/2 );
hf(bf)=1;
yf=hf.*sf;

df = f(2)-f(1);
Fmx = ( f(end)-f(1) +df);
dt = 1/Fmx;
N = length(yf);
T = dt*N;
t = 0:dt:T-dt;
sff = fftshift(yf);
st = Fmx*ifft(sff);
st = real(st);
