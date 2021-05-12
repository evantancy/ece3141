function [array_str] = array2str(array)
%ARRAY2STR
%   Converts vertical or horizontal array into str

assert(isrow(array) | iscolumn(array))

array_str = "";
for i=1:length(array)
    array_str = array_str + num2str(array(i));
end
end
