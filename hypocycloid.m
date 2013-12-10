function [x, y, k] = hypocycloid(R, r, phi0, theta)
%
% hypocycloid.m, (c) Matthew Roughan, 2013
%
% created: 	Tue Dec 10 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% HYPOCYCLOID draws an hypocycloid (the results of rolling one circle inside another)
%     http://en.wikipedia.org/wiki/Hypocycloid
%     http://en.wikipedia.org/wiki/Hypotrochoid
%
% INPUTS:
%              R = radius of the stationary circle (assumes center is at the origin)
%              r = radius of the rolling circle (just touching the other circle)
%           phi0 = starting point of contact as an angle WRT to the x-axis
%          theta = Nx1 vector of angles giving how far the outer circle has rolled
% 
% OUTPUTS:        
%         [x,y] = points on the epicycloid
%                 each is Nx1 vector
%             k = R/r
%                 if k is rational, e.g. p/q for integers p, q, then you get interesting curves
%
% Special cases include
%    deltoid: k = 3
%    astroid: k = 4
% and it is a special case of a hypotrochoid
%
[x, y, k] = hypotrochoid(R, r, r, phi0, theta);

