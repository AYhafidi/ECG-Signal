function [value] = tachy_brachy(R,Ts)

[BPM,D_n,mean] = BPM_R(R,Ts);
if BPM <= 60
    value=1;   %Bradychardia
if BPM >= 100 
    value=2;   %Tachycardia
    
else
    value=0  % No Tachycardia , no Bradychardia
















end