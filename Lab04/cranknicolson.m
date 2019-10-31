function [ U ] = cranknicolson( c_tnext_snext_cn, c_tnext_scur_cn, c_tnext_sprev_cn, c_tcur_snext_cn, c_tcur_scur_cn, c_tcur_sprev_cn, ux0, u0tau, u1tau, N, M, Tau, X )
%CRANKNICOLSON Summary of this function goes here
%   Detailed explanation goes here

U = zeros(N,M);
U(1,:) = ux0(X);
for i = 2:N
    U(i,1) = u0tau(Tau(i));
    U(i,M) = u1tau(Tau(i));
    
    R = (c_tcur_sprev_cn(X(2:(M-1))) .* U(i-1,1:(M-2))) + (c_tcur_scur_cn(X(2:(M-1))) .* U(i-1,2:(M-1))) + (c_tcur_snext_cn(X(2:(M-1))) .* U(i-1,3:M));
    R(1) = R(1) - c_tnext_sprev_cn(X(2))*U(i,1);
    R(end) = R(end) - c_tnext_snext_cn(X(M-1))*U(i,M);
    
    U(i,2:(M-1)) = A_cn(c_tnext_snext_cn, c_tnext_scur_cn, c_tnext_sprev_cn, M-2, Tau, X)\(R');
end

end

