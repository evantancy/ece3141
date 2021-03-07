clear all; close all; clc;
format short
format compact
%% Midtread vs midrise
%{
- Midrise output is more even, has lowest error for input levels at delta/2,
and largest error for input levels at delta.
- Midtread has lowest error for input levels at delta, and largest error
for input levels at delta/2
%}

%% Vector that represents time-varying sinusoid
    testFrequency           = 1e3;                  % 1kHz
    sampleFrequency         = testFrequency*8;      % sampling at 8kHz (greater than Nyquist rate)
    samplePeriod            = 1/sampleFrequency;
    amplitude               = 1;
    duration                = 2;

    samples                 = sampleFrequency * duration;
    timeVector              = (0:samples-1) * samplePeriod;
    signalVector            = amplitude * sin(2*pi * testFrequency * timeVector);
    figure
    hold on
    plot(signalVector)

%% SNR as a function of m (bits per sample)
    count = 1;
    bpsVector = 2:16; % bits per sample vector
    SNRVector = zeros(size(bpsVector));

    for m=bpsVector(1):bpsVector(end)
        levels              = 2^m-1; % odd number of levels
        quantVector         = 2*round(signalVector*(levels-1)/2) / (levels-1); % midtread quantiser
        quantNoiseVector    = signalVector - quantVector;
        Ps                  = 1/length(signalVector) * sum(signalVector.^2);
        Pn                  = 1/length(quantNoiseVector) * sum(quantNoiseVector.^2);
        SNR_calc            = 10*log10(Ps / Pn); % convert to dB
        SNRVector(count)    = SNR_calc; % ensure our indices start from 1
        count               = count + 1;
    end

%% Result
    % uncomment this to play sound
    %sound(quantVector,sampleFrequency)

    plot(quantVector)
    axis([0 20 -1 1])
    hold off
    title('Plot of signal vector and quantised vector')
    legend('signal','quant')

    figure
    plot(bpsVector,SNRVector)
    title('Plot of SNR against m, bits per sample')

    % assume a line of best fit through SNR oops
    coefficients = polyfit(2:16, SNRVector, 1);
    slope = coefficients(1);
