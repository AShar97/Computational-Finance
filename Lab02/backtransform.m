function [V] = backtransform(U, X, Tau, q, qd, K)
%BACKTRANSFORM Summary of this function goes here
%   Detailed explanation goes here
for i = 1:length(Tau)
    for j = 1:length(X)
        V(i, j) = U(i, j) * K * exp(-2\(qd-1)*X(j) - (4\((qd-1)^2) + q)*Tau(i));
    end
end
end

