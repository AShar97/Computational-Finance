function [ mat ] = A_cn( c_tnext_snext_cn, c_tnext_scur_cn, c_tnext_sprev_cn, size, Tau, X )
%A_CN Summary of this function goes here
%   Detailed explanation goes here

i = [1, 1]; j = [1, 2]; k = [c_tnext_scur_cn(X(2)), c_tnext_snext_cn(X(2))];
for p = 2:size-1
    i = [i, p, p, p];
    j = [j, p-1, p, p+1];
    k = [k, c_tnext_sprev_cn(X(p+1)), c_tnext_scur_cn(X(p+1)), c_tnext_snext_cn(X(p+1))];
end
i = [i, size, size];
j = [j, size-1, size];
k = [k, c_tnext_sprev_cn(X(size+1)), c_tnext_scur_cn(X(size+1))];

mat = sparse(i, j, k, size, size);

end

