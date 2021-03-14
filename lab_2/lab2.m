%%
close all; clear all; clc;
format short; format compact;

%% Loading given probabilities and codewords
P_A = 0.0625 * ones(1, 16);
P_B = [0.2, ...
        0.08 * ones(1, 5), ...
        0.06 * ones(1, 6), ...
        0.01 * ones(1, 4)];
P_C = [0.02, ...
        0.08 * ones(1, 5), ...
        0.06 * ones(1, 6), ...
        0.05 * ones(1, 2), ...
        0.06 * ones(1, 2)];

% 3 sets of code words, 1,2,3
code_1 = ["0000", "0001", "0010", "0011", ...
        "0100", "0101", "0110", "0111", ...
        "1000", "1001", "1010", "1011", ...
        "1100", "1101", "1110", "1111"];

code_2 = ["001", "0000", "0001", "0100", ...
        "0101", "0110", "0111", "1000" ...
        "1001", "1010", "1011", "1100", ...
        "1101", "1110", "11110", "11111"];

code_3 = ["101", "0000", "0001", "0100", ...
        "0101", "0110", "0111", "1000" ...
        "1001", "1010", "1011", "1100", ...
        "1101", "1110", "11110", "11111"];

%% Q3
% Calculating entropies for each probability distribution
ent_A = calc_entropy(P_A);
ent_B = calc_entropy(P_B);
ent_C = calc_entropy(P_C);

% Average number of bits/symbol
% For (Prob dist A, code set 1)
ave_A_1 = calc_BPS(code_1, P_A);

% For (Prob dist B, code set 1)
ave_B_1 = calc_BPS(code_1, P_B);
% For (Prob dist B, code set 2)
ave_B_2 = calc_BPS(code_2, P_B);

% For (Prob dist C, code set 2)
ave_C_2 = calc_BPS(code_2, P_C);
% For (Prob dist C, code set 3)
ave_C_3 = calc_BPS(code_3, P_C);

%% Q4
% alphabets a to z
% alphabets = linspace(97, 122, 122-97+1);

% ASCII Representation
% alphabets a to p only
num_chars = 112 - 97 + 1;
alphabet_ascii = linspace(97, 112, num_chars);

% store characters in cell array
count = 0;
alphabet = {};

for i = 1:num_chars
    alphabet{i} = char(alphabet_ascii(i));
end

% generate Huffman codewords
[dict, avg_len] = huffmandict(alphabet, P_B);

% convert huffman codewords to strings and store
huffman_codewords = [];

for j = 1:size(dict, 1)
    fprintf("%s has code => ", dict{j, 1})
    codeword = "";

    for k = 1:size(dict{j, 2}, 2)
        fprintf("%i", dict{j, 2}(k))
        codeword = codeword + dict{j, 2}(k);
    end

    huffman_codewords(j) = codeword;
    fprintf("\n")
end

% convert to cell array
huffman_codewords = strsplit(num2str(huffman_codewords));

% calculate average number of bits per symbol
% For (Prob dist B, huffman code set)
ave_B_huffman = calc_BPS(huffman_codewords, P_B);

% symbols = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"];
% c_symbols = cellstr(symbols);
% [dict, avg_len] = huffmandict(c_symbols, P_B);

%%

HuffmanObject = load('HuffmanText.mat');
symbols = HuffmanObject.AsciiChar;
symbols_prob_dist = HuffmanObject.AsciiProb;
[dict_ascii, avg_len_ascii] = huffmandict(symbols, symbols_prob_dist);
