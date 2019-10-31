clear; clc;

% dX(t) = -μXdt + σdW(t) 
% X(0) = X0.

mu = 10;
sigma = 1;
X0 = 0;

t0 = 0; t1 = 4;
dt = 0.05;

n = (t1-t0)/dt + 1;
T = t0:dt:t1;

a = @(X) -mu*X;
b = @(X) sigma;
da = @(X) -mu;
dda = @(X) 0;
db = @(X) 0;
ddb = @(X) 0;


% a
% exact = @(t) X0*exp( (mu - (sigma^2)/2)*t + sigma*sqrt(t)*normrnd(0,1) );

% b
% X_exact = exact(T);
X_rungekutta = rungekutta(a, b, X0, dt, n, T );
X_taylor = taylor(a, b, da, dda, db, ddb, X0, dt, n, T );

F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Plots for numerical solutions of Black-Scholes diffusion equation'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

subplot(1,1,1, 'Parent',p);
hold on
% plot(T, X_exact);
plot(T, X_rungekutta);
plot(T, X_taylor);
hold off
xlabel("t");
ylabel("X(t)");
legend("Runge-Kutta", "Taylor");

saveas(F,'2b.jpg');

% c
% % dt_range = (0.1).^(1:5);
% dt_range = [0.1, 0.05, 0.01, 0.005, 0.001, 0.0005, 0.0001];
% Error_rungekutta = zeros(1, 7);
% Error_taylor = zeros(1, 7);
% for i = 1:7
%     n = (t1-t0)/dt_range(i) + 1;
%     T = t0:dt_range(i):t1;
%     
%     X_exact = exact(T);
%     X_rungekutta = rungekutta(a, b, X0, dt_range(i), n, T );
%     X_taylor = taylor(a, b, da, dda, db, ddb, X0, dt_range(i), n, T );
%     
%     Error_rungekutta(i) = mean(abs(X_rungekutta - X_exact));
%     Error_taylor(i) = mean(abs(X_taylor - X_exact));
% end
% 
% F = figure('Color','white');
% p = uipanel('Parent',F,'BorderType','none');
% p.Title = 'Plots for numerical solutions of Black-Scholes diffusion equation'; 
% p.TitlePosition = 'centertop';
% p.FontSize = 12;
% p.FontWeight = 'bold';
% 
% subplot(1,1,1, 'Parent',p);
% hold on
% plot(log(dt_range), log(Error_rungekutta));
% plot(log(dt_range), log(Error_taylor));
% hold off
% xlabel("log(dt)");
% ylabel("log(Mean Error)");
% title("dt vs. the mean error");
% legend("Runge-Kutta", "Taylor");
% 
% saveas(F,'2c.jpg');

function [X] = rungekutta(a, b, X0, dt, n, T )
X = zeros(size(T));
X(1) = X0;
for i = 2:n
    rnd = normrnd(0,1);
    X(i) = X(i-1) + a(X(i-1))*dt + b(X(i-1))*sqrt(dt)*rnd + 2\( (b(X(i-1) + a(X(i-1))*dt + b(X(i-1))*dt) - b(X(i-1)))/sqrt(dt) )*dt*(rnd^2 - 1);
end
end

function [r] = randWhat(dt)
U = rand();

if U < 1/6
    r = -sqrt(3*dt);
elseif U < 5/6
    r = 0;
else
    r = sqrt(3*dt);
end

end

function [X] = taylor(a, b, da, dda, db, ddb, X0, dt, n, T )
X = zeros(size(T));
X(1) = X0;
for i = 2:n
    rnd = randWhat(dt);
    X(i) = X(i-1) + a(X(i-1))*dt + b(X(i-1))*rnd + 2\b(X(i-1))*db(X(i-1))*(rnd^2 - dt) + 2\( a(X(i-1))*da(X(i-1)) - 2\(b(X(i-1))^2)*dda(X(i-1)) )*(dt^2) + 2\( da(X(i-1))*b(X(i-1)) + a(X(i-1))*db(X(i-1)) + 2\(b(X(i-1))^2)*ddb(X(i-1)) )*rnd*dt;
end
end