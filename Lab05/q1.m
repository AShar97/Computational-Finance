clear; clc;

T = 1;
K = 10;
r = 0.25;
sigma = 0.6;
delta = 0.2;

q = 2*r/(sigma^2);
qd = 2*(r - delta)/(sigma^2);

% American Put
g = @(x, tau) exp( 4.\( (qd-1)^2 + 4*q ).*tau ) .* max( exp(2.\(qd-1).*x) - exp(2.\(qd+1).*x), 0 );

% Transformed PDE
x0 = -4; x1 = 1;
tau0 = 0; tau1 = 2\(sigma^2)*T;

N = 20; M = 20;

dx = (x1-x0)/(M);
dtau = (tau1-tau0)/(N);

X = x0 + (0:M).*dx;
Tau = tau0 + (0:N).*dtau;

lambda = dtau/(dx^2);
% alpha = lambda * theta;

% theta = 0; FTCS
% theta = 1; BTCS
% theta = 1/2; CN
% alg( theta, g, lambda, X, Tau, N, M )

W_btcs = alg( 1, g, lambda, X, Tau, N, M );

W_cn = alg( 1/2, g, lambda, X, Tau, N, M );

% Back-transformation
fn_S = @(x) K * exp(x);

fn_V = @(W, x) K * W .* exp( -2\x*(qd-1) ) * exp( -tau1*( 4\((qd-1)^2) + q ) );

S = fn_S( X(2:end-1) );

V_btcs = fn_V( W_btcs, X(2:end-1)' );
V_cn = fn_V( W_cn, X(2:end-1)' );

% % Half-difference Case
N2 = N*2; M2 = M*2;

dx2 = dx/2;
dtau2 = dtau/2;

X2 = x0 + (0:M2).*dx2;
Tau2 = tau0 + (0:N2).*dtau2;

lambda2 = 2*lambda; %dtau2/(dx2^2);

W_btcs2 = alg( 1, g, lambda2, X2, Tau2, N2, M2 );

W_cn2 = alg( 1/2, g, lambda2, X2, Tau2, N2, M2 );

S2 = fn_S( X2(2:end-1) );

V_btcs2 = fn_V( W_btcs2, X2(2:end-1)' );
V_cn2 = fn_V( W_cn2, X2(2:end-1)' );

err_btcs = (V_btcs2(2:2:end) - V_btcs);
err_cn = (V_cn2(2:2:end) - V_cn);

% Plot

F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Plots of the numerical solutions for Black-Scholes PDE for American Put'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

subplot(2,1,1, 'Parent',p);
hold on
plot(S, V_btcs, 'r');
plot(S, V_cn, 'b');
plot(S, max(0, K-S), 'g');
legend("BTCS", "CN", "Payoff");
title("Value vs. S");
hold off

subplot(2,1,2, 'Parent',p);
hold on
plot(S, err_btcs, 'r');
plot(S, err_cn, 'b');
legend("BTCS", "CN");
title("Error vs. S");

saveas(F,'1.jpg');