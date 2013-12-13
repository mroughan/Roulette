function [x,y] = undulary(parameters, theta)
%
% undulary.m, (c) Matthew Roughan, 2013
%
% created: 	Wed Nov 27 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% UNDULARY: roulette of ellipse's focus along a straight line
%             
%
% INPUTS:
%         parameters = parameters of ellipse being rolled [x0,y0,a,b]
%             x0, y0 are ignored
%             a, b  = parameters of the ellipse being rolled (a=semi-major axis > b=semi-minor axis)
%         theta = vector of angles by which it has been rolled
%         
% OUTPUTS:        
%         (x,y) = points along the undulary
%         
%         
%

% find out if elliptic integrals are available
common;

% check inputs
if (nargin < 2)
  theta = 0:pi/3:pi; % default range of rotations
end
theta = theta(:);  % make it a column vector
if (length(parameters) < 4)
  error('error parameters = [x0, y0, a, b]');
end
x0 = parameters(1); % ignore this
y0 = parameters(2); % ignore this
a = parameters(3);
b = parameters(4);
if (b <= 0 | a < b)
  error('error: should have a >= b > 0');
end
e = sqrt(a^2 - b^2)/a; % eccentricity of the ellipse
focus = sqrt(a^2-b^2); % distance from y-axis
k = e;
M = k^2;

% calculate arclengths along the ellipse rolled by the specified angles from -pi/2
[points, ell] = ellipse(parameters, theta-pi/2);

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
