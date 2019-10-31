function [ mat ] = A_btcs( l, h, size )
%A Summary of this function goes here
%   Detailed explanation goes here

i = [1, 1]; j = [1, 2]; k = [1+(2*l), -l];
for p = 2:size-1
    i = [i, p, p, p];
    j = [j, p-1, p, p+1];
    k = [k, -l, 1+(2*l), -l];
end
i = [i, size, size];
j = [j, size-1, size];
% k = [k, -l, 1+(2*l)];
k = [k, -l, 1+(2*l) - (l/(1+ (h/2)))];

mat = sparse(i, j, k, size, size);

end

