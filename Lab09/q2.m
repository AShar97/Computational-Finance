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
db = @(X) 0;

% a

% b
X_eulermaruyama = eulermaruyama(a, b, X0, dt, n, T );
X_milstein = milstein(a, b, db, X0, dt, n, T );

F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Plots for numerical solutions of Black-Scholes diffusion equation'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

subplot(1,1,1, 'Parent',p);
hold on
plot(T, X_eulermaruyama);
plot(T, X_milstein);
hold off
xlabel("t");
ylabel("X(t)");
legend("Euler-Maruyama", "Milstein");

saveas(F,'2b.jpg');

% c
% % dt_range = (0.1).^(1:5);
% dt_range = [0.1, 0.05, 0.01, 0.005, 0.001];
% Error_eulermaruyama = zeros(1, 5);
% Error_milstein = zeros(1, 5);
% for i = 1:5
%     n = (t1-t0)/dt_range(i) + 1;
%     T = t0:dt_range(i):t1;
%     
%     X_exact = exact(T);
%     X_eulermaruyama = eulermaruyama(a, b, X0, dt_range(i), n, T );
%     X_milstein = milstein(a, b, db, X0, dt_range(i), n, T );
%     
%     Error_eulermaruyama(i) = mean(abs(X_eulermaruyama - X_exact));
%     Error_milstein(i) = mean(abs(X_milstein - X_exact));
% end

% F = figure('Color','white');
% p = uipanel('Parent',F,'BorderType','none');
% p.Title = 'Plots for numerical solutions of Black-Scholes diffusion equation'; 
% p.TitlePosition = 'centertop';
% p.FontSize = 12;
% p.FontWeight = 'bold';
% 
% subplot(1,1,1, 'Parent',p);
% hold on
% plot(log(dt_range), log(Error_eulermaruyama));
% plot(log(dt_range), log(Error_milstein));
% hold off
% xlabel("log(dt)");
% ylabel("log(Mean Error)");
% title("dt vs. the mean error");
% legend("Euler-Maruyama", "Milstein");
% 
% saveas(F,'2c.jpg');

function [X] = eulermaruyama(a, b, X0, dt, n, T ) %eulermaruyama(mu, sigma, X0, dt, n, T );
X = zeros(size(T));
X(1) = X0;
for i = 2:n
%     X(i) = X(i-1)*(1 - mu*dt) + sigma*sqrt(dt)*normrnd(0,1);
    X(i) = X(i-1) + a(X(i-1))*dt + b(X(i-1))*sqrt(dt)*normrnd(0,1);
end
end

function [X] = milstein(a, b, db, X0, dt, n, T ) %milstein(mu, sigma, X0, dt, n, T );
X = zeros(size(T));
X(1) = X0;
for i = 2:n
%     X(i) = X(i-1)*(1 - mu*dt) + sigma*sqrt(dt)*normrnd(0,1) + 2\sigma*0*dt*((normrnd(0,1))^2 - 1);
    X(i) = X(i-1) + a(X(i-1))*dt + b(X(i-1))*sqrt(dt)*normrnd(0,1) + 2\b(X(i-1))*db(X(i-1))*dt*((normrnd(0,1))^2 - 1);
end
end