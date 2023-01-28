%% introduction 
clc;
clear;
close all;


%% load data 
load('~/Desktop/MICA_project/data/ecg_VF.mat') ;
Ts=1/Fs;

%% VF 

[vf,C1]=ventricular_fibrillation(-ecg,Ts);
bpm=400; %entre 240 et 600

fe = 8000;      
N = 80000;       

% Axe des temps
t = (1:N)/fe;
        
% Génération du sinus
f0 = 1200;
sinus = sin(2*pi*t);
subplot(2,1,2); 
plot(t,sinus);
grid on;
%xlim([0 3*f0]);
        

subplot(2,1,1); 
plot(ecg,'k');
ylabel('Amplitude');
grid on;
title('Cross-correlation between a pure sinus and Signal');
xlabel('Time(secs)') ;
%axis(ax,[-1.5 1.5 -700 700 ]);


