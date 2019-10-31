clear; clc;

% a
c = 1; d = 0;
ux0 = @(x) (sin(pi.*x));
u0t = @(t) 0;
u1t = @(t) 0;
x0 = 0; x1 = 1;
t0 = 0; t1 = 1;

% N_vec = 5 .* [5 10 15 20].^2 = [125 500 1125 2000]; M_vec = [5 10 15 20];

F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Surface plots of the numerical solutions for different values of dx & dt.'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

% 1
N = 125; M = 5;

X = x0 + (0:M-1).*((x1-x0)/(M-1));
T = t0 + (0:N-1).*((t1-t0)/(N-1));

U_ftcs = ftcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_btcs = btcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_cn = cranknicolson( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

subplot(2,2,1, 'Parent',p);
surf(X, T, U_ftcs);
hold on;
surf(X, T, U_btcs);
hold on;
surf(X, T, U_cn);
hold off;
legend('FTCS', 'BTCS', 'Crank-Nicolson');
title("dx = 1/5; dt = 1/125");

% 2
N = 500; M = 10;

X = x0 + (0:M-1).*((x1-x0)/(M-1));
T = t0 + (0:N-1).*((t1-t0)/(N-1));

U_ftcs = ftcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_btcs = btcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_cn = cranknicolson( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

subplot(2,2,2, 'Parent',p);
surf(X, T, U_ftcs);
hold on;
surf(X, T, U_btcs);
hold on;
surf(X, T, U_cn);
hold off;
legend('FTCS', 'BTCS', 'Crank-Nicolson');
title("dx = 1/10; dt = 1/500");

% 3
N = 1125; M = 15;

X = x0 + (0:M-1).*((x1-x0)/(M-1));
T = t0 + (0:N-1).*((t1-t0)/(N-1));

U_ftcs = ftcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_btcs = btcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_cn = cranknicolson( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

subplot(2,2,3, 'Parent',p);
surf(X, T, U_ftcs);
hold on;
surf(X, T, U_btcs);
hold on;
surf(X, T, U_cn);
hold off;
legend('FTCS', 'BTCS', 'Crank-Nicolson');
title("dx = 1/15; dt = 1/1125");

% 4
N = 2000; M = 20;

X = x0 + (0:M-1).*((x1-x0)/(M-1));
T = t0 + (0:N-1).*((t1-t0)/(N-1));

U_ftcs = ftcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_btcs = btcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_cn = cranknicolson( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

subplot(2,2,4, 'Parent',p);
surf(X, T, U_ftcs);
hold on;
surf(X, T, U_btcs);
hold on;
surf(X, T, U_cn);
hold off;
legend('FTCS', 'BTCS', 'Crank-Nicolson');
title("dx = 1/20; dt = 1/2000");

saveas(F,'1a.jpg');

% b
c = 1; d = 0;
ux0 = @(x) (x.^3);
u0t = @(t) 0;
u1t = @(t) 0;
x0 = 0; x1 = 1;
t0 = 0; t1 = 1;

% N_vec = 5 .* [5 10 15 20].^2 = [125 500 1125 2000]; M_vec = [5 10 15 20];

F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Surface plots of the numerical solutions for different values of dx & dt.'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

% 1
N = 125; M = 5;

X = x0 + (0:M-1).*((x1-x0)/(M-1));
T = t0 + (0:N-1).*((t1-t0)/(N-1));

U_ftcs = ftcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_btcs = btcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_cn = cranknicolson( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

subplot(2,2,1, 'Parent',p);
surf(X, T, U_ftcs);
hold on;
surf(X, T, U_btcs);
hold on;
surf(X, T, U_cn);
hold off;
legend('FTCS', 'BTCS', 'Crank-Nicolson');
title("dx = 1/5; dt = 1/125");

% 2
N = 500; M = 10;

X = x0 + (0:M-1).*((x1-x0)/(M-1));
T = t0 + (0:N-1).*((t1-t0)/(N-1));

U_ftcs = ftcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_btcs = btcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_cn = cranknicolson( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

subplot(2,2,2, 'Parent',p);
surf(X, T, U_ftcs);
hold on;
surf(X, T, U_btcs);
hold on;
surf(X, T, U_cn);
hold off;
legend('FTCS', 'BTCS', 'Crank-Nicolson');
title("dx = 1/10; dt = 1/500");

% 3
N = 1125; M = 15;

X = x0 + (0:M-1).*((x1-x0)/(M-1));
T = t0 + (0:N-1).*((t1-t0)/(N-1));

U_ftcs = ftcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_btcs = btcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_cn = cranknicolson( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

subplot(2,2,3, 'Parent',p);
surf(X, T, U_ftcs);
hold on;
surf(X, T, U_btcs);
hold on;
surf(X, T, U_cn);
hold off;
legend('FTCS', 'BTCS', 'Crank-Nicolson');
title("dx = 1/15; dt = 1/1125");

% 4
N = 2000; M = 20;

X = x0 + (0:M-1).*((x1-x0)/(M-1));
T = t0 + (0:N-1).*((t1-t0)/(N-1));

U_ftcs = ftcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_btcs = btcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_cn = cranknicolson( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

subplot(2,2,4, 'Parent',p);
surf(X, T, U_ftcs);
hold on;
surf(X, T, U_btcs);
hold on;
surf(X, T, U_cn);
hold off;
legend('FTCS', 'BTCS', 'Crank-Nicolson');
title("dx = 1/20; dt = 1/2000");

saveas(F,'1b.jpg');

% c
c = 1; d = 0;
ux0 = @(x) (x.*(1-x));
u0t = @(t) 0;
u1t = @(t) 0;
x0 = 0; x1 = 1;
t0 = 0; t1 = 1;

% N_vec = 5 .* [5 10 15 20].^2 = [125 500 1125 2000]; M_vec = [5 10 15 20];

F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Surface plots of the numerical solutions for different values of dx & dt.'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

% 1
N = 125; M = 5;

X = x0 + (0:M-1).*((x1-x0)/(M-1));
T = t0 + (0:N-1).*((t1-t0)/(N-1));

U_ftcs = ftcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_btcs = btcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_cn = cranknicolson( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

subplot(2,2,1, 'Parent',p);
surf(X, T, U_ftcs);
hold on;
surf(X, T, U_btcs);
hold on;
surf(X, T, U_cn);
hold off;
legend('FTCS', 'BTCS', 'Crank-Nicolson');
title("dx = 1/5; dt = 1/125");

% 2
N = 500; M = 10;

X = x0 + (0:M-1).*((x1-x0)/(M-1));
T = t0 + (0:N-1).*((t1-t0)/(N-1));

U_ftcs = ftcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_btcs = btcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_cn = cranknicolson( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

subplot(2,2,2, 'Parent',p);
surf(X, T, U_ftcs);
hold on;
surf(X, T, U_btcs);
hold on;
surf(X, T, U_cn);
hold off;
legend('FTCS', 'BTCS', 'Crank-Nicolson');
title("dx = 1/10; dt = 1/500");

% 3
N = 1125; M = 15;

X = x0 + (0:M-1).*((x1-x0)/(M-1));
T = t0 + (0:N-1).*((t1-t0)/(N-1));

U_ftcs = ftcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_btcs = btcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_cn = cranknicolson( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

subplot(2,2,3, 'Parent',p);
surf(X, T, U_ftcs);
hold on;
surf(X, T, U_btcs);
hold on;
surf(X, T, U_cn);
hold off;
legend('FTCS', 'BTCS', 'Crank-Nicolson');
title("dx = 1/15; dt = 1/1125");

% 4
N = 2000; M = 20;

X = x0 + (0:M-1).*((x1-x0)/(M-1));
T = t0 + (0:N-1).*((t1-t0)/(N-1));

U_ftcs = ftcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_btcs = btcs( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

U_cn = cranknicolson( c, d, ux0, u0t, u1t, x0, x1, t0, t1, N, M );

subplot(2,2,4, 'Parent',p);
surf(X, T, U_ftcs);
hold on;
surf(X, T, U_btcs);
hold on;
surf(X, T, U_cn);
hold off;
legend('FTCS', 'BTCS', 'Crank-Nicolson');
title("dx = 1/20; dt = 1/2000");

saveas(F,'1c.jpg');