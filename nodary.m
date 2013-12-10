function [x,y] = nodary(a, b, theta)
%
% nodary.m, (c) Matthew Roughan, 2013
%
% created: 	Wed Nov 27 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% NODARY: roulette of a hyperbola's focus along a straight line
%         see http://en.wikipedia.org/wiki/Nodary
%               though there is currently a mistake see
%                  http://books.google.com.au/books?id=xb48zk0wJfIC&pg=PA148&lpg=PA148&dq=nodary+parametric+equation&source=bl&ots=RVXw0BYeRW&sig=47ZnhnNY3YtsnxWzw3lUoNdwPjY&hl=en&sa=X&ei=uX-VUqrLFKahige1pYGYCQ&ved=0CEMQ6AEwAw#v=onepage&q=nodary%20parametric%20equation&f=false
%
% INPUTS:
%         a, b = parameters of hyperbola
%         theta = vector of points along which to calculate it
%
% OUTPUTS:        
%         (x,y) = points along the nodary
%         
%
% NB: this requires computation of elliptic integrals, which is done with
%       % http://code.google.com/p/elliptic/
% 
% but R2013b apparently has an elliptical integral calculation 
%       http://www.mathworks.com.au/help/symbolic/elliptice.html
% so we can replace this bit when we ahve the latest version
%

if (nargin < 1)
  a = 0.9;
end
if (nargin < 2)
  b = 1.7;
end
if (nargin < 3)
  theta = -30:0.1:30;
end
if (a<=0 | b<=0)
  error('a and b must be positive');
end

% swap a and b, because conventional derivations are all based on 
%   hyperbola being on its side, not upright
temp = b; 
b = a; 
a = temp;

% http://code.google.com/p/elliptic/
path(path,'/home/mroughan/src/matlab/elliptic')

% solution from 
%    Oprea, p.148
%    with correction: http://en.wikipedia.org/wiki/Nodary
k = cos(atan(b/a))
M = k^2;
e = sqrt(a^2 + b^2)/a;
f = a*e;
c = f;  % just alternative names for focal length
[sn,cn,dn] = ellipj(theta,M);
[F,E,Z] = elliptic12(theta,M);
x =  a*sn + (a/k)*( (1-M)*theta - E );
y = -a*cn + (a/k)*dn;

figure(101)
hold off
plot(0,0)
hold on
plot(x, y)
 
% solution from 
%    Forsyth, p.417 
alpha = atan(b/a);
k = cos(atan(b/a))
M = k^2;
e = sqrt(a^2 + b^2)/a;
f = a*e;
c = f;  % just alternative names for focal length
[sn,cn,dn] = ellipj(theta,M);
[F,E,Z] = elliptic12(theta,M);
x = c +  a*sn - a*( E - theta.*sin(alpha).^2).*sec(alpha);
y = -a*cn + a*sec(alpha).*dn;

figure(101)
plot(x, y, 'c--')
 
% http://www.mathcurve.com/courbes2d/delaunay/delaunay.shtml
%   NB: definition of elliptical integrals they are implicitly using implies
%       we take [F,E,Z] = elliptic12(pi/2-theta, M);
%   also have to swap the meanings of a and b at the moment
c = sqrt(a^2 + b^2);
e = c/a;
k = 1/e
M = k^2;
[F,E,Z] = elliptic12(pi/2-theta, M);
[Fc,Ec,Zc] = elliptic12(pi/2, M);
ell = c*(Ec - E) - (b^2/a)*(Fc - F);
tmp =  sqrt( (e-cos(theta)) ./ ( e+cos(theta)) ); 
x = ell - a*sin(theta).* tmp;
y = b*tmp;

figure(101)
plot(x,y,'r--'); 

% solution from Bendito et al
%   assuming a and b have been swapped around
t = theta / 3; 
g = @(z) sqrt(c^2*cosh(z).^2 - a^2);
for i=1:length(theta)
  ell(i) = quad(g, 0, t(i) );
end
phi = atan(c*sinh(t)/b); % convert to coordinates used in calculating arclength
[F,E,Z] = elliptic12(phi,M);
ell = c*(sqrt(1-M*sin(phi).^2).*tan(phi) + (1-M)*F - E);

tmp = g(t);
x1 = ell - c*sinh(t).*(c*cosh(t) - a)./tmp;
x2 = ell - c*sinh(t).*(c*cosh(t) + a)./tmp; 
y1 =  b*(c*cosh(t) - a) ./ tmp;
y2 = -b*(c*cosh(t) + a) ./ tmp;
x = x2;
y = y2;
figure(101)
plot(x1,y1,'g-'); 
plot(x2,y2,'g--'); 
x = [x1, NaN, x2];
y = [y1, NaN, y2];




