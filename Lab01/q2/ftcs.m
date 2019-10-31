function [ U ] = ftcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M )
%FTCS Summary of this function goes here
%   Detailed explanation goes here

k = (t1-t0)/(N-1);
h = (x1-x0)/(M-1);
l = c*k/(h^2);

U = zeros(N,M);
U(1,:) = ux0(x0 + (0:M-1).*h);
for i = 2:N
    U(i,1) = u0t(t0 + (i-1)*k);
    U(i,2:(M-1)) = U(i-1,2:(M-1)).*(1-(2*l)) + l.*(U(i-1,1:(M-2)) + U(i-1,3:M)) + d*k;
    % U(i,M) = u1t(t0 + (i-1)*k);
    U(i,M) = U(i,M-1)/(1+ (h/2));
end

end

