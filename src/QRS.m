clc;
clear;
close all ;



%load('~/Desktop/MICA_project/data/ecg_normal_1.mat');
Ecg=load('~/Desktop/MICA_project/data/ecg_normal_1.mat');
ecg=-Ecg.ecg;
Fs=Ecg.Fs;
%load('~/Desktop/MICA_project/data/ecg_normal_3.mat');

%% Variables

N_fft=512;
t=0:1/Fs:(length(ecg)-1)/Fs;
N_win=31;

%% Traitement de signal
    %% Spectro
        %spectre=spectro(-ecg,w1,d,N_fft,Fs);
        
    %% Filters Output
        %Signal signal aprés filter passe bas
            signal_sortie_lp=low_pass_filter(ecg);
        %signal cardiaque apres filter passe haut
            Signal=high_pass_filter(signal_sortie_lp);
        %signal cardiaque apres A five-point differentiation filter
            signal_sortie_dp=fivepoint_diff_filter(Signal,1/Fs);
        %Signal squared
            Signal_sortie_squared=signal_sortie_dp.*signal_sortie_dp;
        %signal aprés moving-window integration
            Signal_sortie_wi=moving_window_integration(Signal_sortie_squared,31);
            
            
     %% PQRST locations and BPM
        [R,S,Q,BPM]=QRS_Detection(ecg,Fs,31);
        [P,T]=PT_detection(R,S,Q,Signal);
            
            
%% Affichage des resultats
figure();
%signal cardiaque d'entree
    subplot(2,3,1);
    plot(t,ecg);
    xlim([0 3]); % dessiner 3 periode du signal
    title("Signal cardiaque d'entree");

%signal cardiaque apres filter passe bas
    subplot(2,3,2);
    plot(t,signal_sortie_lp);
    xlim([0 3]); % dessiner 3 periode du signal
    title("Signal cardiaque d'entree lp");

%signal cardiaque apres filter passe haut
    subplot(2,3,3);
    plot(Signal);
    xlim([0 4*Fs]); % dessiner 3 periode du signal
    title("Signal cardiaque d'entree  hp");

%signal cardiaque apres A five-point differentiation filter
    subplot(2,3,4);
    plot(signal_sortie_dp);
    xlim([0 3*Fs]); % dessiner 3 periode du signal
    title("Signal cardiaque d'entree dp");

%Signal squared
    subplot(2,3,5);
    plot(Signal_sortie_squared);
    xlim([0 3*Fs]); % dessiner 3 periode du signal
    title("Signal cardiaque sortie carré");

%signal aprés moving-window integration
    subplot(2,3,6);
    plot(Signal_sortie_wi);
    xlim([0 3*Fs]); % dessiner 3 periode du signal

figure();
h = plot(t,Signal); grid on;
hold on;
plot(t(R),Signal(R), '*','Color','red'); text(t(R),Signal(R),' R ','Color','red','FontSize',14);
plot(t(Q),Signal(Q), '*','Color','red'); text(t(Q),Signal(Q),' Q ','Color','red','FontSize',14);
plot(t(S),Signal(S), '*','Color','red'); text(t(S),Signal(S),' S ','Color','red','FontSize',14);
plot(t(T),Signal(T), '*','Color','red'); text(t(T),Signal(T),' T ','Color','red','FontSize',14);
plot(t(P),Signal(P), '*','Color','red'); text(t(P),Signal(P),' P ','Color','red','FontSize',14);

hold off;
xlim([0 3]);
xlabel('Time (s)');
ylabel('Magnitude');

%% P and T wave detection

%% filtering step
%signal apres le passage en filtre differentiateur
signal_sortie_diff=differentiator(ecg);
%signal apres le passage en filtre passe bas
signal_sortie_lp=low_pass(signal_sortie_diff);

%% P and T detection
%P detection 
%Rinterval = Rinterval_detect(signal_sortie_lp,R);
%reduced_interval=[Rinterval(1) Rinterval(2)*0.7];
%T=zero_detection(signal_sortie_lp,interval); 

