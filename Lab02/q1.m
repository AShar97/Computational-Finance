clear; clc;

T = 1;
K = 10;
r = 0.06;
sigma = 0.3;
delta = 0;

fn_S = @(x) K .* exp(x);
fn_t = @(tau) (T - (2 .* tau ./ (sigma.^2)));

q = 2*r/(sigma^2);
qd = 2*(r - delta)/(sigma^2);

% Transformed PDE
c = 1; d = 0;

x0 = -5; x1 = 1;
% tau0 = 2\(sigma^2)*T; tau1 = 0;
tau0 = 0; tau1 = 2\(sigma^2)*T;

ux0 = @(x) ( max( exp(2\x*(qd + 1)) - exp(2\x*(qd - 1)), 0) );
u0tau = @(tau) 0;
u1tau = @(tau) ( exp(2\x1*(qd + 1) + 4\tau*((qd + 1)^2)) );

N = 25; M = 100;

X = x0 + (0:M-1).*((x1-x0)/(M-1));
Tau = tau0 + (0:N-1).*((tau1-tau0)/(N-1));

U_ftcs = ftcs( c, d, ux0, u0tau, u1tau, x0, x1, tau0, tau1, N, M );

U_btcs = btcs( c, d, ux0, u0tau, u1tau, x0, x1, tau0, tau1, N, M );

U_cn = cranknicolson( c, d, ux0, u0tau, u1tau, x0, x1, tau0, tau1, N, M );

% Back-transformation
S = fn_S(X);
t = fn_t(Tau);

V_ftcs = backtransform(U_ftcs, X, Tau, q, qd, K);
V_btcs = backtransform(U_btcs, X, Tau, q, qd, K);
V_cn = backtransform(U_cn, X, Tau, q, qd, K);

% Plot

F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Surface plots of the numerical solutions for Black-Scholes PDE for European call'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

subplot(1,1,1, 'Parent',p);
surf(S, t, V_ftcs);
title("Forward-Euler for time & central difference for space (FTCS) scheme.");

saveas(F,'1ftcs.jpg');
% 
F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Surface plots of the numerical solutions for Black-Scholes PDE for European call'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

subplot(1,1,1, 'Parent',p);
surf(S, t, V_btcs);
title("Backward-Euler for time & central difference for space (BTCS) scheme.");

saveas(F,'1btcs.jpg');
% 
F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Surface plots of the numerical solutions for Black-Scholes PDE for European call'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

subplot(1,1,1, 'Parent',p);
surf(S, t, V_cn);
title("Crank-Nicolson finite difference scheme.");

saveas(F,'1cn.jpg');