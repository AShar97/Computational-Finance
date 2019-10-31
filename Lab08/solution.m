function [H] = solution(theta, r, sigma, t0, t1, R0, R1, dt, dR, HR1 )
%solution Summary of this function goes here
%   Detailed explanation goes here

% theta: 0 -> FTCS; 1/2 -> CN; 1 -> BTCS;

m = (R1-R0)/dR + 1;
n = (t1-t0)/dt + 1;

t = t0:dt:t1;
R = R0:dR:R1;

H = zeros(n, m);

H(n, :) = HR1(R);
% HR1 = @(R) max(1 - R./t1, 0);
% % dH/dt + dH/dR = 0 at R = 0;
% % H = 0 at R = inf;

for j = n-1:-1:1
    A = zeros(m, m);
    b = zeros(m, 1);
    
    A(1, 1) = ((1-theta)/dR + 1/dt);
    A(1, 2) = (theta-1)/dR;
    A(m, m) = 1;
    
    b(1) = H(j+1, 1)*(1/dt - theta/dR) + H(j+1, 2)*(theta/dR);
    b(m) = 0;
    
    for i = 2:m-1
        A(i, i-1) = (theta-1)*( ((sigma*R(i)/dR)^2)/2 - (1 - r*R(i))/(2*dR) );
        A(i, i) = 1/dt + (1-theta)*((sigma*R(i)/dR)^2);
        A(i, i+1) = (theta-1)*( ((sigma*R(i)/dR)^2)/2 + (1 - r*R(i))/(2*dR) );
        
        b(i) =  H(j+1, i-1)*theta*( ((sigma*R(i)/dR)^2)/2 - (1 - r*R(i))/(2*dR) ) + H(j+1, i)*(1/dt - theta*((sigma*R(i)/dR)^2)) + H(j+1, i+1)*theta*( ((sigma*R(i)/dR)^2)/2 + (1 - r*R(i))/(2*dR) );
    end
    
    H(j, :) = (A\b)';
end

end

