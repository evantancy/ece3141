%%
close all; clear all; clc;
format short; format compact;

%% function definitions
% calculate entropy given a list of probabilities
calc_entropy = @(probs_list) sum(probs_list .* log2(1./probs_list));
nk = @(a,b) nchoosek(a,b);

%%

probabilities = [5,15,40,25,12,3] ./ 100;
probabilities = sort(probabilities,'descend');
H = calc_entropy(probabilities);
disp(H)

vlc_length = [1,2,3,4,5,5];
mean_word_length = sum(probabilities .* vlc_length);
disp(mean_word_length)
%%
nchoosek(7,1)