function [x, y, x_lim, y_lim] = nodary(parameters,  mu)
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
%         parameters = parameters of hyperbola being rolled [x0,y0,a,b]
%                        x0, y0 are ignored
%                        a, b = parameters of hyperbola   -x^2/a^2 + y^2/b^2 = 1
%         mu         = vector of points along original hyperbola (being rolled), used to 
%                      create this curve
%
% OUTPUTS:        
%         (x,y) = points along the nodary
%                     note these are 2xN vectors with one curve corresponding to each focus
%         x_lim = x values of 4 limiting points
%         y_lim = y values of 4 limiting points
%

% find out if elliptic integrals are available
common;

% process inputs
mu = mu(:);
t = log(abs(mu)+1).*sign(mu);

if (length(parameters) < 4)
  error('error parameters = [x0, y0, a, b]');
end
x0 = parameters(1); % ignore this
y0 = parameters(2); % ignore this
a = parameters(3);
b = parameters(4);
if (a<=0 | b<=0)
  error('a and b must be positive');
end

% swap a and b, because conventional derivations are all based on 
%   hyperbola being on its side, not upright
temp = b; 
b = a; 
a = temp;

k = cos(atan(b/a));
e = sqrt(a^2 + b^2)/a;
f = a*e;
c = f;  % f and c just alternative names for focal length

% % solution from 
% %    Oprea, p.148
% %    or with correction: http://en.wikipedia.org/wiki/Nodary
% %    similar Forsyth, p.417 
% [F,E,Z] = elliptic12(pi/2,k^2)
% u = -F:0.01:F;
% [sn,cn,dn] = ellipj(u,k^2); 
% phi = asin(sn);
% % [F,E,Z] = elliptic12(u,k^2);
% [F,E,Z] = elliptic12(phi,k^2);
% x =  a*sn + (a/k)*( (1-k^2)*u - E );
% y = -a*cn + (a/k)*dn;

% figure(101)
% hold off
% plot(0,0)
% hold on
% plot(x, y)

% x =  a*sn - (a/k)*( (1-k^2)*u - E );
% y = -a*cn - (a/k)*dn;
% plot(x, y, 'x')

% % http://www.mathcurve.com/courbes2d/delaunay/delaunay.shtml
% %   NB: definition of elliptical integrals they are implicitly using implies
% %       we take [F,E,Z] = elliptic12(pi/2-theta, k^2);
% %   also have to swap the meanings of a and b at the moment
% c = sqrt(a^2 + b^2);
% e = c/a;
% k = 1/e
% [F,E,Z] = elliptic12(pi/2-theta, k^2);
% [Fc,Ec,Zc] = elliptic12(pi/2, k^2);
% ell = c*(Ec - E) - (b^2/a)*(Fc - F);
% tmp =  sqrt( (e-cos(theta)) ./ ( e+cos(theta)) ); 
% x = ell - a*sin(theta).* tmp;
% y = b*tmp;

% figure(101)
% plot(x,y,'r--'); 

% solution from Enrique Bendito, Mark J. Bowick and Agustin Medina, 
%   "Delaunay Surfaces", http://arxiv.org/abs/1305.5681
%   assuming a and b have been swapped around

% first calculate arclengths for hyperbola
g = @(z) sqrt(c^2*cosh(z).^2 - a^2);
% ell = zeros(size(t));
% if (elliptic_available)
%   phi = atan(c*sinh(t)/b); % convert to coordinates used in calculating arclength
%   [F,E,Z] = elliptic12(phi,k^2);
%   ell = c*(sqrt(1-k^2*sin(phi).^2).*tan(phi) + (1-k^2)*F - E);
% else
%   for i=1:length(theta)
%     ell(i) = quad(g, 0, t(i) );
%   end
% end
[point, ell] = hyperbola([0,-b,b,a], mu);

% now do the transform
tmp = g(t);
x1 = ell - c*sinh(t).*(c*cosh(t) - a)./tmp;
x2 = ell - c*sinh(t).*(c*cosh(t) + a)./tmp; 
y1 =  b*(c*cosh(t) - a) ./ tmp;
y2 = -b*(c*cosh(t) + a) ./ tmp;
x = x2;
y = y2;
x = [x1, x2];
y = [y1, y2];

% also compute limiting points for nodary
[Fc, Ec] = ellipke(k^2);
x_lim1 =  a + c*((1-k^2)*Fc - Ec);
x_lim2 = -a + c*((1-k^2)*Fc - Ec);
x_lim = [x_lim1 -x_lim1 x_lim2 -x_lim2];
y_lim = [b b -b -b];


