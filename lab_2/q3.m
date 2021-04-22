clear all; close all; clc;

P_A = 0.0625*ones(1,16);
P_B = [0.2 0.08*ones(1,5) 0.06*ones(1,6) 0.01*ones(1,4)];
P_C = [0.02 0.08*ones(1,5) 0.06*ones(1,6) 0.05*ones(1,2) 0.06*ones(1,2)];

code1 = ["0000" "0001" "0010" "0011" "0100" "0101" "0110" "0111"...
        "1000" "1001" "1010" "1011" "1100" "1101" "1110" "1111"];
code2 = ["001" "0000" "0001" "0100" "0101" "0110" "0111" "1000" ...
        "1001" "1010" "1011" "1100" "1101" "1110" "11110" "11111"];
code3 = ["101" "0000" "0001" "0100" "0101" "0110" "0111" "1000" ...
        "1001" "1010" "1011" "1100" "1101" "1110" "11110" "11111"];

%% Entropy (P_A)
    entA = 0;
    for i = 1:length(P_A)
        entA = entA + -P_A(i)*log2(P_A(i));
    end
    
%% Entropy (P_B)
    entB = 0;
    for i = 1:length(P_B)
        entB = entB + -P_B(i)*log2(P_B(i));
    end
    
%% Entropy (P_C)
    entC = 0;
    for i = 1:length(P_C)
        entC = entC + -P_C(i)*log2(P_C(i));
    end
    
%% Average number of bits/symbol (P_A, Code Set 1)
    ave_A_1 = 0;
    for i = 1:length(P_A)
        ave_A_1 = ave_A_1 + P_A(i)*strlength(code1(i));
    end
        
%% Average number of bits/symbol (P_B, Code Set 1)
    ave_B_1 = 0;
    for i = 1:length(P_B)
        ave_B_1 = ave_B_1 + P_B(i)*strlength(code1(i));
    end
    
%% Average number of bits/symbol (P_B, Code Set 2)
    ave_B_2 = 0;
    for i = 1:length(P_B)
        ave_B_2 = ave_B_2 + P_B(i)*strlength(code2(i));
    end

%% Average number of bits/symbol (P_C, Code Set 2)
    ave_C_2 = 0;
    for i = 1:length(P_C)
        ave_C_2 = ave_C_2 + P_C(i)*strlength(code2(i));
    end
    
%% Average number of bits/symbol (P_C, Code Set 3)
    ave_C_3 = 0;
    for i = 1:length(P_C)
        ave_C_3 = ave_C_3 + P_C(i)*strlength(code3(i));
    end
