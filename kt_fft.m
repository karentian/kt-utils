function [f amp] = kt_fft(data)
% function [f P1] = kt_fft(data)

% Inputs: 
%   - data: t x 1 vector 
% Outputs: 
%   - f: frequencies (Hz) 
%   - amp: power

%% Directories (for figure saving) 
s.saveFigs = 1; 
s.figDir = '/Users/karen/Dropbox/github/ta-esoa/ta-esoa_analysis/figs/timing0001_KT'; 
s.figType = 'png'; 

addpath(genpath('../kt-utils')); 

%% FFT setup 
% Need at least 2 points to estimate a sin
% If N is the number of points in a signal 
% N/2 is the maximum frequency that can be sampled (i.e. Nyquist frequency)

data = dat'; % check input dimensions 

%% Check data
nSamples = length(data); 

%% Zero pad input data 
clear nSamplesDesired dataOriginal padSize dataPadded
nSamplesDesired = 2^nextpow2(length(data)); % next power of 2 makes for more efficient algorithm 
dataOriginal = data; 
padSize = 2^nextpow2(length(data)) - nSamples; % 0, 1024*2-numel(dataOriginal); 
dataPadded = padarray(dataOriginal,[padSize 1],0,'post');

%% Setup 
% Fmax = 1/(2*dt); % Nyquist frequency 
Fs = 1000;                      % Sampling frequency                    
T = 1/Fs;                       % Sampling period       
L = length(dataPadded);         % Length of signal
y = fft(dataPadded);            % FFT the signal -- 2-sided frequency, complex
P2 = abs(y/L);                  % 2-sided PSD -- 2-sided frequency, real magnitude
P1 = P2(1:L/2+1);               % 1-sided PSD -- 1-sided frequency, real magnitude
P1(2:end-1) = 2*P1(2:end-1);    % Power, scaled to match time series magnitude (*)
df = Fs/length(dataPadded);     % frequency resolution 
f = Fs*(0:(L/2))/L;             % frequencies 

% rename 
amp = P1; 

%% Plot settings
color = [92 107 192]/255; 
xlims = [0 300]; 
% Anything to call out? Will draw vertical lines at these frequencies 
fAnnotate = [20 120]; % ssver freq, line noise 
    
%% Plot fft 
if plotFigs
    figure
    subplot 121
    hold on
    meg_figureStyle
    plot(f,P1,'LineWidth',2,'Color',color)
    ylabel('Amplitude')
    xlabel('Frequency (Hz)')
    xlim(xlims)
    xline(fAnnotate)

    subplot 122
    hold on
    meg_figureStyle
    plot(log(f),log(P1),'LineWidth',2,'Color',color)
    ylabel('Log(Amplitude)')
    xlabel('Log(Frequency) (Hz)')
    xlim(log(xlims))
    
    kt_saveFigs('FFT_timing0001_KT', s)
end

