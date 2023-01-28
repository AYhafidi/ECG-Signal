function [value] = atrial_fibrillation(R,Ts)
 %SACF : for the sample auto-covariance function
                                            
    [BPM,D_n,SME]=BPM_R(R,Ts); %  the vector difference Delta
    N=length(D_n);
    
    
    %SCE:Sample mean estimate
   
  for k=0:1:N-2
        somme = zeros(0, N-k-1);
        for n=0:1:N-k-1
            somme(n+1) = (D_n(n+k+1)-SME) * (D_n(n+1)-SME);
        end
        SACF_not_adapted(k+1) = 1/(N-k-1) * sum(somme);
  end
  
  a=floor(length(SACF_not_adapted)/2);
  SACF=SACF_not_adapted(1:a); %SACF(1) est notre pic d'interet , on veut evoluer s'il peut etre cons
  max2=max(SACF(floor(0.8*a):a));
  max1=0.25*SACF(1);
  
  if max1>max2
      value=1;
  end
  if max1<=max2
      value=0;
  end
end