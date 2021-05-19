function [f,sf]= Florier(t,st)
dt = t(2)-t(1);
T=t(end);
df = 1/T;
N = length(st);
f=-N/2*df : df : N/2*df-df;
sf = fft(st);
sf = T/N*fftshift(sf);

