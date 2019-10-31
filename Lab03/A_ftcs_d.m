function [ mat ] = A_ftcs_d( c_next_ftcs_d, c_cur_ftcs_d, c_prev_ftcs_d, size, Time, Space )
%A_FTCS_D Summary of this function goes here
%   Detailed explanation goes here

i = [1, 1]; j = [1, 2]; k = [c_cur_ftcs_d(Space(2)), c_next_ftcs_d(Space(2))];
for p = 2:size-1
    i = [i, p, p, p];
    j = [j, p-1, p, p+1];
    k = [k, c_prev_ftcs_d(Space(p+1)), c_cur_ftcs_d(Space(p+1)), c_next_ftcs_d(Space(p+1))];
end
i = [i, size, size];
j = [j, size-1, size];
k = [k, c_prev_ftcs_d(Space(size+1)), c_cur_ftcs_d(Space(size+1))];

mat = sparse(i, j, k, size, size);

end

