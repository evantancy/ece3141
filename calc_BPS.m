function [average_BPS] = calc_BPS(codeword_set,prob_dist)
%CALC_BPS Summary of this function goes here
%   Calculate average bits per symbol given a probability distribution, and
%   a set of code words
%   Inputs:
%       codeword_set: set of code words
%       prob_dist: probability distribution corresponding to each code word
%   Output:
%       average_BPS: average bits per sample

    average_BPS = 0;
    assert(isrow(prob_dist) | iscolumn(prob_dist))
    assert(isequal(size(prob_dist),size(codeword_set)))
    
    for i=1:length(prob_dist)
        average_BPS = average_BPS + prob_dist(i) * strlength(codeword_set(i));
    end
end
