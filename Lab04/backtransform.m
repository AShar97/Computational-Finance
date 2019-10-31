function [V] = backtransform(U, X, Tau, Pm)
%BACKTRANSFORM Summary of this function goes here
%   Detailed explanation goes here
for i = 1:length(Tau)
    for j = 1:length(X)
        V(i, j) = U(i, j) * (X(j) + Pm);
    end
end
end

