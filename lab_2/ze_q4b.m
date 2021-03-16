clear all; close all; clc;
format short; 
format compact;

%% 
HuffmanObject = importdata('HuffmanText.mat');
char = HuffmanObject.AsciiChar;
prob = HuffmanObject.AsciiProb;
[dict,aveCodeLength] = huffmandict(char,prob);

%% Longest/Shortest code word
    maxLength = max(cellfun('length',dict(:,2)));
    minLength = min(cellfun('length',dict(:,2)));
    
    maxProb = max(prob);
    minProb = min(prob);
    
%% Encode/Decode
    string = ('a "typical" text string reduced using Huffman coding?');
    
    string_binary = dec2bin(string);
    num_string = numel(string_binary);
    
    enco = huffmanenco(string, dict);
    d2b_enco = de2bi(enco);
    num_enco = numel(enco);

    comression = num_enco/num_string;
    reduction = (num_string-num_enco)/num_string;
    