clear; clc;

p = @(x) x^2 - 2;
q = @(x) 2*x + 1;
f = @(x) x^2 + 4*x - 5;

x0 = 0; x1 = 1;
N = 11;
h = (x1 - x0)/(N-1);
X = x0:h:x1;

%Aji
A_trap = zeros(N, N); F_trap = zeros(N, 1);
A_simp = zeros(N, N); F_simp = zeros(N, 1);

% u(0) = 2
A_trap(1, 1) = 1; F_trap(1) = 2;
A_simp(1, 1) = 1; F_simp(1) = 2;
% u'(1) = 0
A_trap(N, N-1) = -1/h; A_trap(N, N) = 1/h; F_trap(N) = 0;
A_simp(N, N-1) = -1/h; A_simp(N, N) = 1/h; F_simp(N) = 0;

for i = 2:(N-1)
    
    a = (X(i-1)+X(i))/2;
    b = (X(i)+X(i+1))/2;
    
    % I1
    A_trap(i, i) = ( p(X(i-1)) + 2*p(X(i)) + p(X(i+1)) )/( 2*h );
    A_trap(i, i-1) = -( p(X(i-1)) + p(X(i)) )/( 2*h );
    A_trap(i, i+1) = -( p(X(i)) + p(X(i+1)) )/( 2*h );
    
    A_simp(i, i) = ( p(X(i-1)) + 4*p( a ) + 2*p(X(i)) + 4*p( b ) + p(X(i+1)) )/( 6*h );
    A_simp(i, i-1) = -( p(X(i-1)) + 4*p( a ) + p(X(i)) )/( 6*h );
    A_simp(i, i+1) = -( p(X(i)) + 4*p( b ) + p(X(i+1)) )/( 6*h );
    
    % I2
    A_trap(i, i) = A_trap(i, i) + q(X(i))*h;
    
    A_simp(i, i) = A_simp(i, i) + ( q( a ) + 2*q(X(i)) + q( b ) ) * h/6;
    A_simp(i, i-1) = A_simp(i, i-1) + q( a ) * h/6;
    A_simp(i, i+1) = A_simp(i, i+1) + q( b ) * h/6;
    
    % I3
    F_trap(i) = f(X(i))*h;
    
    F_simp(i) = ( f( a ) + f(X(i)) + f( b ) ) * h/3;
end

U_trap = A_trap\F_trap;
U_simp = A_simp\F_simp;

% Plot

F = figure('Color','white');
p = uipanel('Parent',F,'BorderType','none');
p.Title = 'Plot of Solution by Finite Element Method'; 
p.TitlePosition = 'centertop';
p.FontSize = 12;
p.FontWeight = 'bold';

subplot(1,1,1, 'Parent',p);
hold on
plot(X, U_trap, 'r');
plot(X, U_simp, 'b');
legend("Trapezoidal", "Simpsons");
% title("U vs. X");
xlabel('X');
ylabel('U');
hold off

saveas(F,'2.jpg');