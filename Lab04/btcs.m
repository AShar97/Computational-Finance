function [ U ] = btcs( c_next_btcs, c_cur_btcs, c_prev_btcs, ux0, u0tau, u1tau, N, M, Tau, X )
%BTCS Summary of this function goes here
%   Detailed explanation goes here

U = zeros(N,M);
U(1,:) = ux0(X);
for i = 2:N
    U(i,1) = u0tau(Tau(i));
    U(i,M) = u1tau(Tau(i));
    
    R = U(i-1,2:(M-1))';
    R(1) = R(1) - c_prev_btcs(X(2))*U(i,1); 
    R(end) = R(end) - c_next_btcs(X(M-1))*U(i,M);
    
    U(i,2:(M-1)) = A_btcs(c_next_btcs, c_cur_btcs, c_prev_btcs, M-2, Tau, X )\R;
end

end

