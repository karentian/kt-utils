function [f amp P1] = kt_fft(data,plotFigs)
% function [f P1] = kt_fft(data)

% Inputs: 
%   - data: t x 1 vector 
% Outputs: 
%   - f: frequencies (Hz) 
%   - amp: power


%% FFT setup 
% Need at least 2 points to estimate a sin
% If N is the number of points in a signal 
% N/2 is the maximum frequency that can be sampled (i.e. Nyquist frequency)

% if size(data,1)==1
%     data = data'; % check input dimensions
% end

if nargin<2
    plotFigs = 1; 
end

%% Check data
nSamples = length(data); 

%% Zero pad input data 
clear nSamplesDesired dataOriginal padSize dataPadded
% nfft = 2^nextpow2(length(data)); % next power of 2 makes for more efficient algorithm 
nfft = length(data); 
dataOriginal = data; 
padSize = nfft - nSamples; % 0, 1024*2-numel(dataOriginal); 
dataPadded = padarray(dataOriginal,[padSize 1],0,'post');

%% Setup 
% Fmax = 1/(2*dt); % Nyquist frequency 
Fs = 1000;                      % Sampling frequency                    
T = 1/Fs;                       % Sampling period       
L = length(dataPadded);         % Length of signal
y = fft(dataPadded,nfft);            % FFT the signal -- 2-sided frequency, complex
P2 = abs(y/L);                  % 2-sided PSD -- 2-sided frequency, real magnitude
P1 = P2(1:floor(L/2+1));        % 1-sided PSD -- 1-sided frequency, real magnitude
P1(2:end-1) = 2*P1(2:end-1);    % Power, scaled to match time series magnitude (*)
df = Fs/length(dataPadded);     % frequency resolution 
f = Fs*(0:(L/2))/L;             % frequencies 

% rename 
amp = P1; 

%% Plot settings
color = [92 107 192]/255; 
xlims = [0 150]; 
% Anything to call out? Will draw vertical lines at these frequencies 
fAnnotate = [10 20 120]; % ssver freq, line noise 
% ylims = [0 200]; 
    
%% Plot fft 
if plotFigs
    figure
    subplot 121
    hold on
    meg_figureStyle
    plot(f(2:end),P1(2:end),'LineWidth',2,'Color',color)
    ylabel('Amplitude')
    xlabel('Frequency (Hz)')
    xlim(xlims)
    % ylim(ylims)
    for iA = 1:numel(fAnnotate)
        xline(fAnnotate(iA),'label',sprintf('%d Hz',fAnnotate(iA)))
    end

    subplot 122
    hold on
    meg_figureStyle
    plot(log(f),log(P1),'LineWidth',2,'Color',color)
    ylabel('Log(Amplitude)')
    xlabel('Log(Frequency) (Hz)')
    xlim(log(xlims))
    xline(log(fAnnotate))
end

