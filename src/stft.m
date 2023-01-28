%%Implemantation of the function:
function [X, f,t] = stft(x,w,d,N_fft,Fs)
% This function computes the stft for m = [0, d, 2d, 3d...]
% This function outputs are:
% -> X, which is a matrix of n_fft lines and M columns
% M is the number of elements of m
% X(i,j) is the value of the spectrogram for time t(i) and frequency f(j)
% -> f, is a column vector of the frequencies (in Hz)
% -> t, is a row vector containing the times of the beginning of the windows
L=length(x); %he length of x
M=floor(L/d); 
N=length(w);
X=zeros(N,M); %Initialisation of the matrix
%% fragmentation
for i=0:M-2
    X(:,i+1)=transpose(x(1+i*d:N+i*d));
end
X(:,M)=transpose([x(1+(M-1)*d:L) zeros(1,N-length(X(1+(M-1)*d:L)))]) ;
%% Fenetrage
for i=1:M
   X(:,i)=w.*X(:,i);
end
%% Dft
   



X=fft(X,N_fft); 
f = (0:N_fft-1)*Fs/N_fft; %Creation of the vector f
t = 0:(L-1)/Fs; %Creation of the vector t for time



end
 
