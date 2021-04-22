function [output_array] = str2array(input_str)
%STR2ARRAY 
%   Splits elements of a string and convert into an array

assert(mean(class(input_str)) == mean(class('a')))

input_str = char(num2cell(input_str));
output_array = reshape(str2num(input_str), 1, []);
end

