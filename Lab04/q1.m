clear; clc;

T = 1;
K = 10;
r = 0.04;
sigma = 0.25;
delta = 0.1;

Pm = K;

fn_S = @(x) Pm.*x./(1-x);
fn_t = @(tau) (T-tau);

% Transformed PDE
x0 = 0; x1 = 1;
tau0 = 0; tau1 = T;

ux0 = @(x) ( max( 2*x - 1, 0) );
u0tau = @(tau) ( ux0(0) * exp(-r*tau) );
u1tau = @(tau) ( ux0(1) * exp(-delta*tau) );

N = 11; M = 11;

k = (tau1-tau0)/(N-1);
h = (x1-x0)/(M-1);

X = x0 + (0:M-1).*h;
Tau = tau0 + (0:N-1).*k;

c_next_ftcs = @(x) (2\((sigma.*x./h).^2).*(1-(x.^2)) + (r-delta).*x.*(1-x)./(2*h)).*k;
c_cur_ftcs = @(x) (- ((sigma.*x./h).^2).*(1-(x.^2)) - (r.*(1-x) + delta.*x) + 1/k).*k;
c_prev_ftcs = @(x) (2\((sigma.*x./h).^2).*(1-(x.^2)) - (r-delta).*x.*(1-x)./(2*h)).*k;

c_next_btcs = @(x) (- 2\((sigma.*x./h).^2).*(1-(x.^2)) - (r-delta).*x.*(1-x)./(2*h)).*k;
c_cur_btcs = @(x) (((sigma.*x./h).^2).*(1-(x.^2)) + (r.*(1-x) + delta.*x) + 1/k).*k;
c_prev_btcs = @(x) (- 2\((sigma.*x./h).^2).*(1-(x.^2)) + (r-delta).*x.*(1-x)./(2*h)).*k;

c_tnext_snext_cn = @(x) 4.\( -((sigma.*x./h).^2).*(1-(x.^2)) - (r-delta).*x.*(1-x)./h );
c_tnext_scur_cn = @(x) (1/k + 2\((sigma.*x./h).^2).*(1-(x.^2)) + (r.*(1-x) + delta.*x));
c_tnext_sprev_cn = @(x) 4.\( -((sigma.*x./h).^2).*(1-(x.^2)) + (r-delta).*x.*(1-x)./h );

c_tcur_snext_cn = @(x) 4.\( ((sigma.*x./h).^2).*(1-(x.^2)) + (r-delta).*x.*(1-x)./h );
c_tcur_scur_cn = @(x) (1/k - 2\((sigma.*x./h).^2).*(1-(x.^2)) - (r.*(1-x) + delta.*x));
c_tcur_sprev_cn = @(x) 4.\( ((sigma.*x./h).^2).*(1-(x.^2)) - (r-delta).*x.*(1-x)./h );

U_ftcs = ftcs( c_next_ftcs, c_cur_ftcs, c_prev_ftcs, ux0, u0tau, u1tau, N, M, Tau, X );

U_btcs = btcs( c_next_btcs, c_cur_btcs, c_prev_btcs, ux0, u0tau, u1tau, N, M, Tau, X );

U_cn = cranknicolson( c_tnext_snext_cn, c_tnext_scur_cn, c_tnext_sprev_cn, c_tcur_snext_cn, c_tcur_scur_cn, c_tcur_sprev_cn, ux0, u0tau, u1tau, N, M, Tau, X );

% Back-transformation
S = fn_S(X);
t = fn_t(Tau);

V_ftcs = backtransform(U_ftcs, X, Tau, Pm);
V_btcs = backtransform(U_btcs, X, Tau, Pm);
V_cn = backtransform(U_cn, X, Tau, Pm);

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