clear all; close all; clc;

P_A = 0.0625*ones(1,16);
P_B = [0.2 0.08*ones(1,5) 0.06*ones(1,6) 0.01*ones(1,4)];
P_C = [0.02 0.08*ones(1,5) 0.06*ones(1,6) 0.05*ones(1,2) 0.06*ones(1,2)];

sym16 = ['a';'b';'c';'d';'e';'f';'g';'h';'i';'j';'k';'l';'m';'n';'o';'p'];
c_sym16 = cellstr(sym16);

%% Mean number of bits/symbol
    dictB = huffmandict(c_sym16,P_B);

    ave_B_huff = 0;
    for i = 1:length(P_B)
        ave_B_huff = ave_B_huff + P_B(i)*cellfun('length',dictB(i,2));
    end
    
%% All symbols have the same probability
    dictA = huffmandict(c_sym16,P_A);
    
%% 20 symbols instead of 16 symbols
    P_A_20 = 1/20*ones(1,20);

    sym20 = ['a';'b';'c';'d';'e';'f';'g';'h';'i';'j';'k';'l';'m';'n';'o';'p';'q';'r';'s';'t'];
    c_sym20 = cellstr(sym20);
    
    dictA20 = huffmandict(c_sym20,P_A_20);
    