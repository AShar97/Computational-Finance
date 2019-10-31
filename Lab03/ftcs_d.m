function [ U ] = ftcs_d( c_next_ftcs_d, c_cur_ftcs_d, c_prev_ftcs_d, uxT, u0t, u1t, N, M, Time, Space )
%FTCS_D Summary of this function goes here
%   Detailed explanation goes here

U = zeros(N,M);
U(N,:) = uxT(Space);
for i = N-1:-1:1
    U(i,1) = u0t(Time(i));
    U(i,M) = u1t(Time(i));
    
    R = -(U(i+1,2:(M-1)))';
    R(1) = R(1) - c_prev_ftcs_d(Space(2))*U(i,1); 
    R(end) = R(end) - c_next_ftcs_d(Space(M-1))*U(i,M);
    
    U(i,2:(M-1)) = A_ftcs_d(c_next_ftcs_d, c_cur_ftcs_d, c_prev_ftcs_d, M-2, Time, Space )\R;
end

end

