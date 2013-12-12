function [x, y, k] = epicycloid(R, r, phi0, theta)
%
% epicycloid.m, (c) Matthew Roughan, 2013
%
% created: 	Tue Dec 10 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% EPICYCLOID draws an epicycloid (the result of rolling one circle around another and tracing a point)
%     http://en.wikipedia.org/wiki/Epicycloid
%     http://en.wikipedia.org/wiki/Epitrochoid
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
%    Cardiod: R=r
% and it is a special case of an epitrochoid
%
[x, y, k] = epitrochoid(R, r, r, phi0, theta);
