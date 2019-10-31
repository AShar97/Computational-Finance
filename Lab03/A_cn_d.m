function [ mat ] = A_cn_d( c_tcur_snext_cn_d, c_tcur_scur_cn_d, c_tcur_sprev_cn_d, size, Time, Space )
%A_CN_D Summary of this function goes here
%   Detailed explanation goes here

i = [1, 1]; j = [1, 2]; k = [c_tcur_scur_cn_d(Space(2)), c_tcur_snext_cn_d(Space(2))];
for p = 2:size-1
    i = [i, p, p, p];
    j = [j, p-1, p, p+1];
    k = [k, c_tcur_sprev_cn_d(Space(p+1)), c_tcur_scur_cn_d(Space(p+1)), c_tcur_snext_cn_d(Space(p+1))];
end
i = [i, size, size];
j = [j, size-1, size];
k = [k, c_tcur_sprev_cn_d(Space(size+1)), c_tcur_scur_cn_d(Space(size+1))];

mat = sparse(i, j, k, size, size);

end

