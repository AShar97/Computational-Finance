function [ U ] = cranknicolson_d( c_tnext_snext_cn_d, c_tnext_scur_cn_d, c_tnext_sprev_cn_d, c_tcur_snext_cn_d, c_tcur_scur_cn_d, c_tcur_sprev_cn_d, uxT, u0t, u1t, N, M, Time, Space )
%CRANKNICOLSON_D Summary of this function goes here
%   Detailed explanation goes here

U = zeros(N,M);
U(N,:) = uxT(Space);
for i = N-1:-1:1
    U(i,1) = u0t(Time(i));
    U(i,M) = u1t(Time(i));
    
    R = (c_tnext_sprev_cn_d(Space(2:(M-1))) .* U(i+1,1:(M-2))) + (c_tnext_scur_cn_d(Space(2:(M-1))) .* U(i+1,2:(M-1))) + (c_tnext_snext_cn_d(Space(2:(M-1))) .* U(i+1,3:M));
    R(1) = R(1) - c_tcur_sprev_cn_d(Space(2))*U(i,1);
    R(end) = R(end) - c_tcur_snext_cn_d(Space(M-1))*U(i,M);
    
    U(i,2:(M-1)) = A_cn_d(c_tcur_snext_cn_d, c_tcur_scur_cn_d, c_tcur_sprev_cn_d, M-2, Time, Space)\(R');
end

end

