function [ U ] = btcs_d( c_next_btcs_d, c_cur_btcs_d, c_prev_btcs_d, uxT, u0t, u1t, N, M, Time, Space )
%BTCS_D Summary of this function goes here
%   Detailed explanation goes here

U = zeros(N,M);
U(N,:) = uxT(Space);
for i = N-1:-1:1
    U(i,1) = u0t(Time(i));
    U(i,2:(M-1)) =  (c_prev_btcs_d(Space(2:(M-1))) .* U(i+1,1:(M-2))) + (c_cur_btcs_d(Space(2:(M-1))) .* U(i+1,2:(M-1))) + (c_next_btcs_d(Space(2:(M-1))) .* U(i+1,3:M));
    U(i,M) = u1t(Time(i));
end

end

