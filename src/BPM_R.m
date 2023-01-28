
function [BPM,D_n,mean] = BPM_R(R,Ts)
    N=length(R);
    D_n=(R(2:N)-R(1:N-1))*Ts;
    mean=(1/N)*sum(D_n);
    BPM=60/(mean);
end

