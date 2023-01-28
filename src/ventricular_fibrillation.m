function [n,C1]= ventricular_fibrillation(signal,Ts)
t=1:Ts:(length(signal)-1)*Ts ;
bpm=400; %entre 240 et 600
%Sinus=sin(2*pi*bpm*t);
C1 = xcorr(signal);   %correlation entre le signal et le sinus     
       
[~,I] = max(abs(C1));
n = C1(I);


end 


