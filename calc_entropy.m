function [entropy_val] = calc_entropy(prob_dist)
%CALC_ENTROPY Summary of this function goes here
%   Detailed explanation goes here
    entropy_val = 0;
    assert(isrow(prob_dist) | iscolumn(prob_dist))
    for i=1:length(prob_dist)
        entropy_val = entropy_val + -prob_dist(i) * log2(prob_dist(i));
    end
end