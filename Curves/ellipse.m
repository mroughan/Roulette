function [points, s] = ellipse(parameters, theta)
%
% ellipse.m, (c) Matthew Roughan, 2013
%
% created: 	Mon Nov 25 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% ELLIPSE is a parametric representation of an ellipse in terms of the 
%         angle theta around the center
%
% INPUTS:
%         parameters = [x0, y0, a, b]
%             (x0, y0) = cordinates of the centre of the ellipse
%             (a, b)   = semi-major, and semi-minor axes
%                          a > b         
%         theta        = angles (Nx1 column vector) of points
%                          angle is WRT to the x-axis
%
% OUTPUTS:        
%         points       = Nx2 set of (x,y) coordinates of points on the ellipse
%         s            = Nx1 vector of arclengths from -ve y-axis 
%

path(path,'../');
elliptic_int_test;


% check inputs
theta = theta(:);  % make it a column vector
if (length(parameters) < 4)
  error('error parameters = [x0, y0, a, b]');
end
x0 = parameters(1);
y0 = parameters(2);
a = parameters(3);
b = parameters(4);
if (b <= 0 | a < b)
  error('error: should have a >= b > 0');
end
e = sqrt(a^2 - b^2)/a; % eccentricity

% parametric equation of ellipse with semi-major axis parallel to x-axis
x = x0 + a*cos(theta);
y = y0 + b*sin(theta);
points = [x,y];

% calculate the arclengths
k = e;
M = k^2;
% this is if theta is angle to x-axis
% [k, e] = ellipke(M); % = elliptic12(pi/2,M)
% [F,E,Z] = elliptic12(pi/2 - theta,M);
% ell = a*(e - E); % the arclength along the ellipse, from the semi-major axis

% compute the arclength along the ellipse, from the semi-minor axis (the negative y axis)
if (elliptic_available)
  [F,E,Z] = elliptic12(theta+pi/2, M);
else
  for i=1:length(theta)
    E(i) = quad( @(t) sqrt(1 - M*sin(t).^2), 0, theta(i)+pi/2);
  end
end
s = a*E;
