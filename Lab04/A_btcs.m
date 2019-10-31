function [ mat ] = A_btcs( c_next_btcs, c_cur_btcs, c_prev_btcs, size, Tau, X )
%A_BTCS Summary of this function goes here
%   Detailed explanation goes here

i = [1, 1]; j = [1, 2]; k = [c_cur_btcs(X(2)), c_next_btcs(X(2))];
for p = 2:size-1
    i = [i, p, p, p];
    j = [j, p-1, p, p+1];
    k = [k, c_prev_btcs(X(p+1)), c_cur_btcs(X(p+1)), c_next_btcs(X(p+1))];
end
i = [i, size, size];
j = [j, size-1, size];
k = [k, c_prev_btcs(X(size+1)), c_cur_btcs(X(size+1))];

mat = sparse(i, j, k, size, size);

end

