clear all; close all; clc;

%% Audio sample
    %filename=['ShortClip_Shine On.wav'];
    filename=['12secSpeechSample - Speeches That Changed The World - Intro.wav'];

    [signalVector,sampleFrequency]=audioread(filename);
    [samples,x]=size(signalVector);
    if x>1
        disp('Warning: This is not a mono recording')
    end
    duration = samples/sampleFrequency;
    display=[num2str(duration),' second audio file, sampled at ', num2str(sampleFrequency),' Hz'];
    disp(display);

%% SNR as a function of m (bits per sample)
count = 1;
bpsVector = 2:16; % bits per sample vector
SNRVector = zeros(size(bpsVector));

for m=bpsVector(1):bpsVector(end)
    levels              = 2^m-1;                                           % odd number of levels
    quantVector         = 2*round(signalVector*(levels-1)/2) / (levels-1);
    quantNoiseVector    = signalVector - quantVector;
    Ps                  = 1/length(signalVector) * sum(signalVector.^2);
    Pn                  = 1/length(quantNoiseVector) * sum(quantNoiseVector.^2);
    SNR_calc            = 10*log10(Ps / Pn);
    SNRVector(count)      = SNR_calc;
    count               = count + 1;
end


%% Result
    % uncomment this to play sound
    %sound(quantVector,sampleFrequency)

    plot(bpsVector,SNRVector)

    coefficients = polyfit(bpsVector, SNRVector, 1)
    slope = coefficients(1)
