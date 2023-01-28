%% introduction 
clc;
clear;
close all;




%% load data 
load('~/Desktop/MICA_project/data/PatientData.mat') ;

%% Parametres
    %%Parametres
Fs=200;
N_fft=512;
Ts=1/Fs;
Tw=4; %8 %Duree de la porte en seconde 
d=Tw*Fs/2;
N_win=31;  %largeur de la porte
w=hamming(Tw*Fs);

%% QRS complex and P&T detection 

for i=1:15

    %% sous-échantillonage
    ecg{i,1}=downsample(ecg{i,1},5);
    
    %% Detection QRS
            [R,S,Q,BPM,intervales]=QRS_Detection(ecg{i,1},Fs,N_win);
            %Intervales
            intervale{i,1}=intervales;
            %BPM
            BPMecg{i,1}=BPM;
            %R
            Recg{i,1}=R;
            %Q
            Qecg{i,1}=Q;
            %S
            Secg{i,1}=S;
            %P et T
            
end
%% P and T detection
        % On ne plot pas le signal numero 9 parce qu'il fait partie des
        % pathologies et du coup il n'a pas de "P and T waves"
for i=1:8
[P,T] = PT_detection(Recg{i,1},Secg{i,1},Qecg{i,1},-ecg{i,1});
Pecg{i,1}=P;
Tecg{i,1}=T;
end
for i=10:15
[P,T] = PT_detection(Recg{i,1},Secg{i,1},Qecg{i,1},-ecg{i,1});
Pecg{i,1}=P;
Tecg{i,1}=T;
end 

%% Affichage des Signaux et des spectrogramme associé
for i=1:15
    ecg_PB{i,1}=low_pass_filter(high_pass_filter(ecg{i,1}));
    figure();
    % Plot des Signaux
    t=0:1/Fs:(length(ecg_PB{i,1})-1)/Fs;
    subplot(1,2,1);
    plot(t,ecg_PB{i,1});
    xlim([0 3]);
    hold on;
    plot(t(Recg{i,1}),ecg_PB{i,1}(Recg{i,1}), '*','Color','red'); text(t(Recg{i,1}),ecg_PB{i,1}(Recg{i,1}),' R ','Color','red','FontSize',14);
    plot(t(Qecg{i,1}),ecg_PB{i,1}(Qecg{i,1}), '*','Color','red'); text(t(Qecg{i,1}),ecg_PB{i,1}(Qecg{i,1}),' Q ','Color','red','FontSize',14);
    plot(t(Secg{i,1}),ecg_PB{i,1}(Secg{i,1}), '*','Color','red'); text(t(Secg{i,1}),ecg_PB{i,1}(Secg{i,1}),' S ','Color','red','FontSize',14);
%     plot(t(Tecg{i,1}),ecg_PB{i,1}(Tecg{i,1}), '*','Color','red'); text(t(Tecg{i,1}),ecg_PB{i,1}(Tecg{i,1}),' T ','Color','red','FontSize',14);
%     plot(t(Pecg{i,1}),ecg_PB{i,1}(Pecg{i,1}), '*','Color','red'); text(t(Pecg{i,1}),ecg_PB{i,1}(Pecg{i,1}),' P ','Color','red','FontSize',14);  
    hold off;
%     
    %Plot Des Spectrogramme
    n=length(ecg{i,1});
    [X_ecg_normal,t1,f1]=spectro(ecg{i,1},w,d,N_fft,Fs);
    subplot(1,2,2);
    imagesc(t1,10*f1, 10*log10(X_ecg_normal));
        colorbar();
    xlabel('time(s)');
    ylabel('Frequency(Hz)');
    title('Ecg-normal-spectrogram');
  
end 

