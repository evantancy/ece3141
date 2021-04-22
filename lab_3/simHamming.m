%
% simHamming.m
% A program to simulate the effect of a binary symmetric channel on
% data encoded using a Hamming code
%

clear variables % Good practice to clear the work space at the beginning

% Define the values of parameters to be used in this run. It is best to
% define them all at the beginning of the script as it makes them easier
% to change.
n=7; %Length of the words after coding
k=4; %Number of message bits
numwords=1000; %The number of words to be encoded and decoded
p=0.01; %Probability of bit error in the BSC

msg=randi([0,1],numwords,k); %Generate the random data
codeword=encode(msg,n,k,'hamming'); %Encode the data
rxinput=bsc(codeword,p); %Simulate the BSC
rxdecode=decode(rxinput,n,k,'hamming'); %Decode the received signal
numerr = biterr(msg,rxdecode); % Count number of errored bits after decode
Percent_error_after_decode = 100*numerr/(numwords*n)

% Compare the transmitted data before coding and the received data
% after decoding to see where errors have occurred
erroredbits=mod(msg+rxdecode,2);
errsperword=sum(erroredbits,2); %Add up the errors in each word

% The array errsperword contains the number of errors in each word sent.
% In this case we are interested in whether the word is decoded correctly,
% not how many errors it has, so we want to count up the number of words
% with one or more errors:
numwitherr=length(find(errsperword));

% Look at the statistics of errors introduced by the BSC
erroredbits_before_decode=mod(codeword+rxinput,2); %Find bit errors
errsperword_before_decode=sum(erroredbits_before_decode,2);

figure; %Create a new figure
K=histc(errsperword_before_decode,0:1:n); %Calculate the histogram
bar(0:1:n,K,0.9,'c'); %Plot the histogram
xlabel('Number of errors');
ylabel('Frequency');
grid on;

m=max(K); %Find the max value in K (used to position labels)
for count=1:(n+1) %Add data labels to the plot
    if K(count)>m*0.1 %This value is bigger than 10% of the max
        %Add blue text slightly inside the bar
        text(count-1,K(count)-m*0.06,sprintf('%d',K(count)), ...
            'HorizontalAlignment','center', ...
            'Color','b', ...
            'EdgeColor', 'b');

    else %This value is less than 10% of the max
        %Add blue text slightly outside the bar
        text(count-1,K(count)+m*0.06,sprintf('%d',K(count)), ...
            'HorizontalAlignment','center', ...
            'Color', 'b', ...
            'EdgeColor', 'b', ...
            'BackgroundColor', 'w');
    end
end
