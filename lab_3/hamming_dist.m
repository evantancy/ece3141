function [hamming_dist] = hamming_dist(code_a, code_b)
    %HAMMING_DIST Summary of this function goes here
    %   Generate hamming distance between two codes
    %   Inputs:
    %       code_a: first code to check
    %       code_b: second code to check,
    %   Output:
    %       hamming_dist: hamming distance between code_a and code_b

    % convert strings to arrays if arrays are used
    if class(code_a) == 'char'
        code_a = str2array(code_a);
    end

    if class(code_b) == 'char'
        code_b = str2array(code_b);
    end

    % ensure we work with row vectors!
    if iscolumn(code_a)
        code_a = code_a';
    end

    if iscolumn(code_b)
        code_b = code_b';
    end

    assert(length(code_a) == length(code_b))

    % get difference for every bit
    hamming_vec = zeros(1, length(code_a));

    for i = 1:length(code_a)
        hamming_vec(i) = abs(code_a(i) - code_b(i));
    end

    % calculate hamming distance
    hamming_dist = sum(hamming_vec);

end
