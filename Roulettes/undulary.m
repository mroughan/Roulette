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
%         a, b  = parameters of the ellipse being rolled (a=semi-major axis > b=semi-minor axis)
%         theta = vector of angles by which it has been rolled
%         
% OUTPUTS:        
%         (x,y) = points along the undulary
%         
%         
%

% find out if elliptic integrals are available
common;

% check input arguments
if (nargin < 1)
  a = 2; % default value
end
if (nargin < 2)
  b = 1.5; % default value
end
if (nargin < 3)
  theta = -30:0.1:30; % default range of rotations
end
if (a<=0 | b<=0)
  error('a and b must be positive');
end
if (a < b)
  error('should have: a >= b');
end 
theta = theta(:); % turn it into a column vector

e = sqrt(a^2 - b^2)/a; % eccentricity of the ellipse
focus = sqrt(a^2-b^2); % distance from y-axis
k = e;
M = k^2;

E = zeros(size(theta));
if (elliptic_available)
  [F,E,Z] = elliptic12(theta, M);
else
  for i=1:length(theta)
    E(i) = quad( @(t) sqrt(1 - M*sin(t).^2), 0, theta(i));
  end
end
ell = a*E; 

% % my derivation
% dsdthetaa = sqrt(1 - e^2*sin(theta).^2);
% x = (focus*cos(theta)).*(1-e*sin(theta)) ./ dsdthetaa + ell;
% y = (-b*e*sin(theta) + b) ./ dsdthetaa;

% or even simpler
tmp = sqrt( (1-e*sin(theta)) ./ ( 1+e*sin(theta)) ); 
x = focus*cos(theta).*tmp + ell;
y = b*tmp;

% and matched more or less to
% http://www.mathcurve.com/courbes2d/delaunay/delaunay.shtml
