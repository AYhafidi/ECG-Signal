function Filtered_Signal = highpass_Chebyshev(Signal)
%HIGHPASS_FILTER Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.5 and Signal Processing Toolbox 8.1.
% Generated on: 10-May-2022 09:58:44

% Chebyshev Type II Highpass filter designed using FDESIGN.HIGHPASS.

% All frequency values are in Hz.
Fs = 200;  % Sampling Frequency

Fstop = 0.2;         % Stopband Frequency
Fpass = 0.4;         % Passband Frequency
Astop = 20;          % Stopband Attenuation (dB)
Apass = 1;           % Passband Ripple (dB)
match = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its CHEBY2 method.
h  = fdesign.highpass(Fstop, Fpass, Astop, Apass, Fs);
Hd = design(h, 'cheby2', 'MatchExactly', match);
Filtered_Signal=filter(Hd,Signal);

% [EOF]
