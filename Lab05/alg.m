function [ W ] = alg( theta, g, lambda, X, Tau, N, M )
%ALG Summary of this function goes here
%   Detailed explanation goes here

% theta = 0; FTCS
% theta = 1; BTCS
% theta = 1/2; CN

alpha = lambda * theta;

A = gallery('tridiag', M-1, -alpha, 1 + 2*alpha, -alpha);

w = g(X(2:end-1), 0)';

% tau-loop
for i = 0:N-1
    b = [w(1) + lambda*(1-theta)*( w(2) - 2*w(1) + g( X(1), Tau(i+1) ) ) + alpha * g( X(1), Tau( (i+1)+1 ) );
        w(2:M-2) + lambda*(1-theta)*( w(3:M-1) - 2*w(2:M-2) + w(1:M-3) );
        w(M-1) + lambda*(1-theta)*( g( X(end), Tau(i+1) ) - 2*w(M-1) + w(M-2) ) + alpha * g( X(end), Tau( (i+1)+1 ) )];
    
%     PSOR
    omega = 1; % 1 <= omega < 2
    
    max_iter = 1000;
    tol = 10^(-5);
    
    for j = 1:max_iter
        w1 = w;
        
        for k = 1:M-1
            r(k) = b(k) - A(k, 1:k-1)*w1(1:k-1) - A(k, k)*w(k) - A(k, k+1:end)*w(k+1:end);
            
            w1(k) = max( g( X(k+1), Tau(i+1) ), w(k) + omega*r(k)/A(k, k) );
        end

        if (norm(w1 - w) < tol)
            break;
        end
    end
    
    W = w1;
end

