function [P,T] = PT_detection(R,S,Q,Signal)
N=length(R);
%P=zeros(1,N-1);
%T=zeros(1,N-1);
%Detection T
for i=1:N-1
    border=floor(R(i) + 0.7*(R(i+1)-R(i)));
    [~,Index_T]=max(Signal( S(1,i) : border));
    T(i)=Index_T+S(1,i)-1; 
end
%Detection P
for i=1:N-1
    border=floor(R(i) + 0.7*(R(i+1)-R(i)));
    [~,Index_P]=max(Signal( border : Q(1,i+1) ));
    P(i)=Index_P+border-1; 
end  
end
    

