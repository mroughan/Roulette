function [point, s] = hyperbola(parameters, mu)
%
% hyperbola.m, (c) Matthew Roughan, 2013
%
% created: 	Mon Nov 25 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% hyperbola is a parametric representation of an hyperbola in terms of the 
%               (y-y0)^2/b^2 - (x-x0)^2/a^2 = 1
%         NB: only returns one branch of hyperbola
%
%
% INPUTS:
%         parameters = [x0, y0, a, b]
%             (x0, y0) = centre
%             (a,b) such that            (x-x0)^2/a^2 - (y-y0)^2/b^2 = -1
%
%         mu        = Nx1 column vector giving locations to calculate it
%                       NB: we use mu, not 'theta' because in this parameterisation
%                                ds ~ dmu (for large mu)
%
% OUTPUTS:        
%         point = Nx2 set of (x,y) coordinates of points on the ellipse
%         
%
common;


% check inputs
mu = mu(:);  % make it a column vector
if (length(parameters) < 4)
  error('error parameters = [x0, y0, a, b]');
end
x0 = parameters(1);
y0 = parameters(2);
a = parameters(3);
b = parameters(4);

% parametric equation of ellipse with 'cup' facing up and dowm
%    NB: we are only returning the upper branch
%    NB: take logs of mu to have more reasonable steps for ds
t = log(abs(mu)+1).*sign(mu);
x = x0 + a*sinh(t);
y = y0 + b*cosh(t);
point = [x,y];

% compute arclengths from the vertex
%     see 
%        Eagle, "The Elliptic Functions as They Should Be", 1958, p.271
%        Byrd and Friedman, "Handbook of the Elliptic Integrals for Engineers and
%                            Scientists", 1971, p.3 
%     and note that those derivations assume the hyperbola is "on its side"
%
e = sqrt(a^2 + b^2)/b; % eccentricity
c = b*e; % distance from centre to focus
focal = c - b; % focal length, which gives y coordinate of focal point
phi = atan((x-x0)*c/a^2);
k = b/c;
if (elliptic_available)
  [F,E,Z] = elliptic12(phi, k^2);
else
  for i=1:length(theta)
    E(i) = quad( @(u) sqrt(1 - k^2*sin(u).^2), 0, phi(i));
    F(i) = quad( @(u) 1./sqrt(1 - k^2*sin(u).^2), 0, phi(i));
  end
end
F = F(:);
E = E(:);
s = c*(sqrt(1-k^2*sin(phi).^2).*tan(phi) + (1-k^2)*F - E);

