function[value]  = ectopic_beat(R,Ts)
 [BPM,D_n,SME]=BPM_R(R,Ts);
 N=length(D_n);
 Ectopic_detection=zeros(1,N-2);
 epsilon=1;
  for i=1:1:N-1
    if  abs(D_n(i+1)-D_n(i))>= epsilon
       Ectopic_detection(i)=0;
       epsilon=1.5*abs(D_n(i+1)-D_n(i));
    else
    Ectopic_detection(i)=1;
    epsilon=1.5*abs(D_n(i+1)-D_n(i));
    end
m=mean(Ectopic_detection)
if m<0.64 & m>0.61:
    value=1;
else
    value=0;
end

end