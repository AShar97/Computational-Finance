clear; clc;

K = 100;
T = 0.2;
r = 0.05;
sigma = 0.25;

A = 1;

t0 = 0; t1 = T;
R0 = 0; R1 = 1;

HR1 = @(R) max(1 - R./t1, 0);
% dH/dt + dH/dR = 0 at R = 0;
% H = 0 at R = inf;

dt = 0.01; dR = 0.1;

t = t0:dt:t1;
R = R0:dR:R1;

% solution(theta, r, sigma, t0, t1, R0, R1, dt, dR, HR1 )
% theta: 0 -> FTCS; 1/2 -> CN; 1 -> BTCS;

H_ftcs = solution(0, r, sigma, t0, t1, R0, R1, dt, dR, HR1 );
H_btcs = solution(1, r, sigma, t0, t1, R0, R1, dt, dR, HR1 );
H_cn = solution(0.5, r, sigma, t0, t1, R0, R1, dt, dR, HR1 );

% Back-transformation
S = A./R;
V_ftcs = S.*H_ftcs;
V_btcs = S.*H_btcs;
V_cn = S.*H_cn;

F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Asian option for the European arithmetic average strike call'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

subplot(3,1,1, 'Parent',p);
surf(S, t, V_ftcs);
title("FTCS");

subplot(3,1,2, 'Parent',p);
surf(S, t, V_btcs);
title("BTCS");

subplot(3,1,3, 'Parent',p);
surf(S, t, V_cn);
title("CN");

saveas(F,'1.jpg');