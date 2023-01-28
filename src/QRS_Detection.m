function [R,S,Q,BPM,intervale] = QRS_Detection(ecg,Fs,N_win)
%% traitement de Signal ECG  

    %Signal signal aprés filter passe bas
    signal_sortie_lp=low_pass_filter(ecg);
    
    %signal cardiaque apres filter passe haut
    Signal=high_pass_filter(signal_sortie_lp);
    
    %signal cardiaque apres A five-point differentiation filter
    signal_sortie_dp=fivepoint_diff_filter(Signal,1/Fs);
    
    %Signal squared
    Signal_sortie_squared=signal_sortie_dp.*signal_sortie_dp;
    
    %signal aprés moving-window integration
    Signal_sortie_wi=moving_window_integration(Signal_sortie_squared,N_win);


%% Parametres
    Seuil=0.1*max(Signal_sortie_wi);
    Retard=floor((N_win-1)/2);
%% QRS Intervales
    Intervale=Signal_sortie_wi.*(Signal_sortie_wi>Seuil);
    intervale=[];
    for i=1:(length(Signal_sortie_wi)-1)
        if Intervale(i)==0 && Intervale(i+1)~=0
            intervale=[intervale i+1];
        elseif Intervale(i)~=0 && Intervale(i+1)==0
            intervale=[intervale i];
        end
    end
      intervale=intervale-Retard;
%% QRS locations
       N=length(intervale)/2;
       R=zeros(1,N);
       Q=zeros(1,N);
       S=zeros(1,N);
       %% Detection R
       for i=0:N-1
           [~,Index]=max(Signal( intervale(1+2*i) : intervale(2+2*i) ));
           R(i+1)=intervale(1+2*i)+Index-1;
       end
       %% Detection QS
       for i=0:N-1
           [~,Index_Q]=min(Signal( intervale(1+2*i) : R(i+1) ));
           [~,Index_S]=min(Signal( R(i+1) : intervale(2+2*i) ));
           Q(i+1)=intervale(1+2*i)+Index_Q-1;
           S(i+1)=R(i+1)+Index_S-1;
       %% Detection PT
       %[P,T]=PT_detection(R,S,ecg);
           
 %% BPM
    D_n=(R(2:N)-R(1:N-1))/Fs;
    mean=(1/N)*sum(D_n);
    BPM=60/(mean);

end

