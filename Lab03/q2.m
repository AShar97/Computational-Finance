clear; clc;

T = 1;
K = 10;
r = 0.06;
sigma = 0.3;
delta = 0;

x0 = 0; x1 = 20;
t0 = 0; t1 = 1;

uxT = @(x) ( max(K - x, 0) );
u0t = @(t) ( x1 - K*exp(-r*(T-t)) );
u1t = @(t) 0;

N = 10; M = 10;

k = (t1-t0)/(N-1);
h = (x1-x0)/(M-1);

Space = x0 + (0:M-1).*(h);
Time = t0 + (0:N-1).*(k);

c_next_ftcs_d = @(s) (2\((sigma.*s./h).^2) + (r-delta)/(2*h)).*k;
c_cur_ftcs_d = @(s) -((sigma.*s./h).^2 + r + 1/k).*k;
c_prev_ftcs_d = @(s) (2\((sigma.*s./h).^2) - (r-delta)/(2*h)).*k;

c_next_btcs_d = @(s) (2\((sigma.*s./h).^2) + (r-delta)/(2*h)).*k;
c_cur_btcs_d = @(s) -((sigma.*s./h).^2 + r - 1/k).*k;
c_prev_btcs_d = @(s) (2\((sigma.*s./h).^2) - (r-delta)/(2*h)).*k;

c_tnext_snext_cn_d = @(s) 4.\( ((sigma.*s./h).^2) + (r-delta).*s./h );
c_tnext_scur_cn_d = @(s) (1/k - 2\((sigma.*s./h).^2));
c_tnext_sprev_cn_d = @(s) 4.\( ((sigma.*s./h).^2) - (r-delta).*s./h );

c_tcur_snext_cn_d = @(s) 4.\( - ((sigma.*s./h).^2) - (r-delta).*s./h );
c_tcur_scur_cn_d = @(s) (1/k + 2\((sigma.*s./h).^2));
c_tcur_sprev_cn_d = @(s) 4.\( - ((sigma.*s./h).^2) + (r-delta).*s./h );

U_ftcs = ftcs_d( c_next_ftcs_d, c_cur_ftcs_d, c_prev_ftcs_d, uxT, u0t, u1t, N, M, Time, Space );

U_btcs = btcs_d( c_next_btcs_d, c_cur_btcs_d, c_prev_btcs_d, uxT, u0t, u1t, N, M, Time, Space );

U_cn = cranknicolson_d( c_tnext_snext_cn_d, c_tnext_scur_cn_d, c_tnext_sprev_cn_d, c_tcur_snext_cn_d, c_tcur_scur_cn_d, c_tcur_sprev_cn_d, uxT, u0t, u1t, N, M, Time, Space );

% Plot

F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Surface plots of the numerical solutions for Black-Scholes PDE for European put'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

subplot(1,1,1, 'Parent',p);
surf(Space, Time, U_ftcs);
title("Forward-Euler for time & central difference for space (FTCS) scheme.");

saveas(F,'2ftcs.jpg');

F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Surface plots of the numerical solutions for Black-Scholes PDE for European put'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

subplot(1,1,1, 'Parent',p);
surf(Space, Time, U_btcs);
title("Backward-Euler for time & central difference for space (BTCS) scheme.");

saveas(F,'2btcs.jpg');

F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Surface plots of the numerical solutions for Black-Scholes PDE for European put'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

subplot(1,1,1, 'Parent',p);
surf(Space, Time, U_cn);
title("Crank-Nicolson finite difference scheme.");

saveas(F,'2cn.jpg');