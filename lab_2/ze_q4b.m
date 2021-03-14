clear all; close all; clc;

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
    text = ('a "typical" text string reduced using Huffman coding?');
    enco = huffmanenco(text, dict);
    deco = huffmanenco(enco, dict);
    equal = isequal(text,deco)