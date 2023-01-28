
%% Introduction of the workspace
clc;
clear;
close all ;

%% Data
ecg1=load('~/Desktop/MICA_project/data/ecg_normal_1.mat');
ecg2=load('~/Desktop/MICA_project/data/ecg_VF.mat'); 

%% Parametres
Fs=ecg1.Fs;
ecg_normal_1=-ecg1.ecg;
ecg_VF=ecg2.ecg;
N_fft=512;
n=length(ecg_normal_1);
Ts=1/Fs;
Tw=8; %8 %Duree de la porte en seconde 
d=Tw*Fs/2;
%%Traitement de Signal:
w=hamming(Tw*Fs);
[X_ecg_normal_1,t1,f1]=spectro(ecg_normal_1,w,d,N_fft,Fs);
[X_ecg_VF,t2,f2]=spectro(ecg_VF,w,d,N_fft,Fs);


%%Affichage des resultats:
figure();
% subplot(1,2,1);
imagesc(t1,500*f1, 10*log10(X_ecg_normal_1));
        colorbar();
       
        
        xlabel('time(s)');
        ylabel('Frequency(Hz)');
        title('Ecg-normal-1 spectrogram');
figure();

%  subplot(1,2,2);       
 imagesc(t2,100*f2, 10*log10(X_ecg_VF));
        colorbar();
        
       
        xlabel('Time(s)');
        ylabel('Frequency(Hz)');
        title('Ecg-VF spectrogram');
