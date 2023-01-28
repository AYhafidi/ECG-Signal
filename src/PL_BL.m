clc;
clear;
close all ;
%% Importer data

Ecg=load('~/Desktop/MICA_project/data/ecg_noisePL.mat');
ECG=load('~/Desktop/MICA_project/data/ecg_noiseBL.mat');

ecg_bl=ECG.ecg;
ecg_pl=Ecg.ecg;
Fs=Ecg.Fs;
Tw=4;
d=Tw*Fs/2;
N_fft=2^10;
Fn=Fs/2;
Fc=50; %Hz
Wp=Fc/Fn;
Wc=(Fc+5)/Fn;
rp=1;
rs=20;
t=0:1/Fs:(length(ecg_pl)-1)/Fs;
f=Fs*((1-1/N_fft)*(-1/2):1/N_fft:(1-1/N_fft)*(1/2));

%% Signaux filtré
Ecg_filtered_pl=lowpass_butterworth(-ecg_pl);
Ecg_filtered_hl=highpass_Chebyshev(-ecg_bl);


%% Plot des figures
% PLot su signal en fonction de temps

figure();
% Signal ecg with power line noise
subplot(2,2,1);
plot(t,-ecg_pl);
xlabel('temps');
ylabel('ecg_{pl}(t)');
title('signal ECG power line noise');
xlim([0 3]); % 3 seconde du signal

% DSP Signal ecg with power power line noise
subplot(2,2,2);
DSP=fftshift(abs(fft(xcorr(-ecg_pl,'biase'),N_fft)));
semilogy(f,DSP);
title('DSP ECG Noise Powerline');

% Signal ecg with power power line filtré noise
subplot(2,2,3);
plot(t,Ecg_filtered_pl);
xlabel('temps');
ylabel('ecg_{pl_{filtré}}(t)');
title('signal ECG base line noise filtré');
xlim([0 3]); % 3 seconde du signal

xlabel('temps');
ylabel('ecg_{pl}(t)');
title('signal ECG power line noise');
xlim([0 3]); % 3 seconde du signal

% DSP Signal ecg with power power line noise
subplot(2,2,2);
DSP=fftshift(abs(fft(xcorr(-ecg_pl,'biase'),N_fft)));
semilogy(f,DSP);
title('DSP ECG Noise Powerline');

% Signal ecg with power power line filtré noise
subplot(2,2,3);
plot(t,Ecg_filtered_pl);
xlabel('temps');
ylabel('ecg_{pl_{filtré}}(t)');
title('signal ECG base line noise filtré');
xlim([0 3]); % 3 seconde du signal


% DSP Signal ecg with power power line noise Filtré
subplot(2,2,4);
DSP_ecg_lp=fftshift(abs(fft(xcorr(Ecg_filtered_pl,'biase'),N_fft)));
semilogy(f,DSP_ecg_lp);
title('DSP ECG Noise Powerline');

figure();

% Signal ecg with Base line noise
subplot(2,2,1);
plot(t,-ecg_bl);
xlabel('temps');
ylabel('ecg_{bl}(t)');
title('signal ECG power line noise');
xlim([5 10]); % 3 seconde du signal

% DSP Signal ecg with Base line noise
subplot(2,2,2);
DSP=fftshift(abs(fft(xcorr(-ecg_bl,'biase'),N_fft)));
semilogy(f,DSP);
title('DSP ECG Noise Powerline');

% Signal ecg with Base line noise filtré
subplot(2,2,3);
plot(t,Ecg_filtered_hl);
xlabel('temps');
ylabel('ecg_{bl_{filtré}}(t)');
title('signal ECG base line noise filtré');
xlim([20 25]); % 3 seconde du signal

% DSP Signal ecg with Base line noise Filtré
subplot(2,2,4);
DSP_ecg_hp=fftshift(abs(fft(xcorr(Ecg_filtered_hl,'biase'),N_fft)));
semilogy(f,DSP_ecg_hp);
title('DSP ECG Noise Baseline filtré');

