function [x,y] = undulary(a, b, theta)
%
% undulary.m, (c) Matthew Roughan, 2013
%
% created: 	Wed Nov 27 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% UNDULARY: roulette of ellipse's focus along a straight line
%             http://books.google.com.au/books?id=xb48zk0wJfIC&pg=PA148&lpg=PA148&dq=nodary+parametric+equation&source=bl&ots=RVXw0BYeRW&sig=47ZnhnNY3YtsnxWzw3lUoNdwPjY&hl=en&sa=X&ei=uX-VUqrLFKahige1pYGYCQ&ved=0CEMQ6AEwAw#v=snippet&q=nodary%20%20undulary&f=false
%
% INPUTS:
%         a, b = parameters of hyperbola
%         theta    = vector of points along which to calculate it
%                       = angles of rotation
%         
%         
% OUTPUTS:        
%         (x,y) = points along the nodary
%         
%         
%  needs incomplete elliptic integrals of second kind, see
%     http://code.google.com/p/elliptic/
%

path(path,'/home/mroughan/src/matlab/elliptic')

if (nargin < 1)
  a = 2;
end
if (nargin < 2)
  b = 1.5;
end
if (nargin < 3)
  u = -30:0.1:30;
end
if (a<=0 | b<=0)
  error('a and b must be positive');
end
if (a < b)
  error('should have: a >= b');
end 

e = sqrt(a^2 - b^2)/a; % eccentricity of the ellipse
focus = sqrt(a^2-b^2); % distance from y-axis
k = e;
M = k^2;

[F,E,Z] = elliptic12(theta, M);
ell = a*E; 

% % old complicated form
% dsdtheta = a*sqrt(1 - e^2*sin(theta).^2);
% x = ( a*focus*cos(theta) - (a^2 - b^2)*cos(theta).*sin(theta)) ...
%     ./ dsdtheta ...
%     + ell;
% y = (-b*focus*sin(theta) + a*b) ...
%     ./ dsdtheta;

% % my derivation
% dsdthetaa = sqrt(1 - e^2*sin(theta).^2);
% x = (focus*cos(theta)).*(1-e*sin(theta)) ./ dsdthetaa + ell;
% y = (-b*e*sin(theta) + b) ./ dsdthetaa;

% or later form
tmp = sqrt( (1-e*sin(theta)) ./ ( 1+e*sin(theta)) ); 
x = focus*cos(theta).*tmp + ell;
y = b*tmp;

% % % http://www.mathcurve.com/courbes2d/delaunay/delaunay.shtml
% % %   which is the same, but with the ellipse starting on its point end
% [F,E,Z] = elliptic12(pi/2-theta, M);
% [Fc,Ec,Zc] = elliptic12(pi/2, M);
% ell = a*(Ec - E);
% tmp =  sqrt( (1-e*cos(theta)) ./ ( 1+e*cos(theta)) ); 
% x = ell - focus*sin(theta).* tmp;
% y = b*tmp; 
