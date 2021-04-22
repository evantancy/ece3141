function [check_bits] = check_hamming(input)
    %CHECK_HAMMING
    % Description:
    %   Generates parity check bits p1,p2,p3 based on an input code of 4 bits
    %   THIS IMPLEMENTATION IS BASED ON THE HAMMING(7,4) code
    % Output:
    %       check_bits: array of 3 bits [p1,p2,p3]
    % Input:
    %       input: 4 bit array
    assert(length(input) == 4)
    
    % MATLAB likes to put the parity bits in front of the original code
    % instead of at the end like in the lectures!
    p1 = mod(input(1) + input(3) + input(4), 2);
    p2 = mod(input(1) + input(2) + input(4), 2);
    p3 = mod(sum(input(2:4)),2);
    parity_vec = [p1, p2, p3];
    for i = 1:length(parity_vec)
        
        if mod(parity_vec(i), 2) == 1
            % make parity bit 1 to achieve even parity
            check_bits(i) = 1;
        else
            % do nothing
            check_bits(i) = 0;
        end

    end

end
