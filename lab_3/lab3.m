%%
clear all; close all; clc;
format short; format compact;

%% Q3: Hamming coding of individual messages
%     msg = {};
%     codeword = {};
%     received = {};

%    n_messages = 5;

    numwords = 1;
    len_codeword = 7;
    len_msg = 4;

    % Print results header
        fprintf("%s\t %s\t %s\t %s\n", "codeword", "hamming", "check_bits", "decoded")

%     for i = 1:n_messages
        % Generate random word
            msg = randi([0 1], numwords, len_msg);
        % Encode with Hamming
            codeword = encode(msg, len_codeword, len_msg, 'hamming');
        % Decode with Hamming
            received = decode(codeword, len_codeword, len_msg, 'hamming');
        % Print results
            fprintf("%s\t\t %s\t %s\t\t %s\n", array2str(msg), array2str(codeword), array2str(check_hamming(msg)), array2str(received))
%     end

%% Q4: Decoding errored code words
    % Represent signal at receiver input after passing through a BSC
        rxinput_q3 = codeword;
    % Change one of the bits of rxinput
        rxinput_q3(3) = ~rxinput_q3(3);
    % Decode our corrupted codeword
        rx_decoded = decode(rxinput_q3, len_codeword, len_msg, 'hamming');

%% Q5: A Monte Carlo simulation using a Binary Symmetric Channel
    % Generate random word
        msg = randi([0 1], numwords, len_msg);
    % Encode with Hamming
        codeword = encode(msg, len_codeword, len_msg, 'hamming');
    % Simulate effect of transmitting code word through a BSC
        error_prob = 0.1;
        rxinput_q4 = bsc(codeword, error_prob);
        fprintf("%s => %s\n", array2str(codeword), array2str(rxinput_q4))

%% Q6: Longer Hamming Codes

%% Q7: Polynomial Error Correcting Codes
    n = 15;                                                 % Code length
    k = 11;                                                 % Message length
    data = randi([0 1],k,1);                                % Create a binary message having length k
    gpol = cyclpoly(n,k);                                   % Create a generator polynomial for a cyclic code
    parmat = cyclgen(n,gpol);                               % Create a parity-check matrix by using the generator polynomial
    trt = syndtable(parmat);                                % Create a syndrome decoding table by using the parity-check matrix
    encData = encode(data,n,k,'cyclic/binary',gpol);        % Encode the data

    n_iter = 1e4;
    for i=1:n_iter
        % Introduce errors in the 4th and 7th bits of the encoded sequence.
        encData(4) = ~encData(4);
        encData(7) = ~encData(7);

        decData = decode(encData,n,k,'cyclic/binary',gpol,trt); % Decode the corrupted sequence.
        numerr = (1/n_iter) * numerr + biterr(data,decData);                           % Count bit errors
    end
    

%% Q7 Hamming VS Polynomial
    
    encData_hamming = encode(data,n,k,'hamming');
    encData_hamming(4) = ~encData_hamming(4);
    encData_hamming(7) = ~encData_hamming(7);
    decData_hamming = decode(encData_hamming,n,k,'hamming');
    numerr_hamming = biterr(data, decData_hamming)
    % Print results header
        fprintf("%s\t\t %s\t\t %s\n", "data", "polynomial", "hamming")
    % Print results
        fprintf("%s\t %s\t %s\n", array2str(data), ...
                                array2str(decData), ...
                                array2str(decData_hamming))
                            
                            
%% Q7: Finding k

target = 1e-11;
p = 0.001;
res = [];
for k = 1:14
    res(k) = nchoosek(15,k) * p^(k+1) * (1-p)^(14-k);
end

