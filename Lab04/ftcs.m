function [ U ] = ftcs( c_next_ftcs, c_cur_ftcs, c_prev_ftcs, ux0, u0tau, u1tau, N, M, Tau, X )
%FTCS Summary of this function goes here
%   Detailed explanation goes here

U = zeros(N,M);
U(1,:) = ux0(X);
for i = 2:N
    U(i,1) = u0tau(Tau(i));
    U(i,2:(M-1)) =  (c_prev_ftcs(X(2:(M-1))) .* U(i-1,1:(M-2))) + (c_cur_ftcs(X(2:(M-1))) .* U(i-1,2:(M-1))) + (c_next_ftcs(X(2:(M-1))) .* U(i-1,3:M));
    U(i,M) = u1tau(Tau(i));
end

end

