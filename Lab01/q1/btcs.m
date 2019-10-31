function [ U ] = btcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M )
%BTCS Summary of this function goes here
%   Detailed explanation goes here

k = (t1-t0)/(N-1);
h = (x1-x0)/(M-1);
l = c*k/(h^2);

U = zeros(N,M);
U(1,:) = ux0(x0 + (0:M-1).*h);
for i = 2:N
    U(i,1) = u0t(t0 + (i-1)*k);
    U(i,M) = u1t(t0 + (i-1)*k);
    
    R = (U(i-1,2:(M-1)))' + d*k;
    R(1) = R(1) + l*U(i,1); 
    R(end) = R(end) + l*U(i,M);
    
    U(i,2:(M-1)) = A_btcs(l, M-2)\R;
end

end

