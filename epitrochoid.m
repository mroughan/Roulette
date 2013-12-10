function [x, y, k] = epitrochoid(R, r, d, phi0, theta)
%
% epicycloid.m, (c) Matthew Roughan, 2013
%
% created: 	Tue Dec 10 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% EPITROCHOID draws an epicycloid (the results of rolling one circle around another)
%     http://en.wikipedia.org/wiki/Epitrochoid
%
% INPUTS:
%              R = radius of the stationary circle (assumes center is at the origin)
%              r = radius of the rolling circle (just touching the other circle)
%              d = radius of point being traced
%           phi0 = starting point of contact as an angle WRT to the x-axis
%          theta = Nx1 vector of angles giving how far the outer circle has rolled
% 
% OUTPUTS:        
%         [x,y] = points on the epicycloid
%                 each is Nx1 vector
%             k = R/r
%                 if k is rational, e.g. p/q for integers p, q, then you get interesting curves
%
% Special cases:
%        epicycloid d=r
%        limacon R=r
%
theta = theta(:);
k = R/r;
x = r*(k+1)*cos(theta) - d*cos( (k+1)*theta );
y = r*(k+1)*sin(theta) - d*sin( (k+1)*theta );

% now rotate everything by phi0
A = [[cos(phi0) -sin(phi0)];
     [sin(phi0) cos(phi0)]];
points = A*[x'; y'];
x = points(1,:)';
y = points(2,:)';

