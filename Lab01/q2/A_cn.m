function [ mat ] = A_cn( l, h, size )
%A_CN Summary of this function goes here
%   Detailed explanation goes here

i = [1, 1]; j = [1, 2]; k = [1+l, -l/2];
for p = 2:size-1
    i = [i, p, p, p];
    j = [j, p-1, p, p+1];
    k = [k, -l/2, 1+l, -l/2];
end
i = [i, size, size];
j = [j, size-1, size];
% k = [k, -l/2, 1+l];
k = [k, -l/2, 1+l - ((l/2)/(1+ (h/2)))];

mat = sparse(i, j, k, size, size);

end

