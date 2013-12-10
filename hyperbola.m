function [point] = hyperbola(parameters, mu)
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
%         mu        = Nx1 column vector
%
% OUTPUTS:        
%         point = Nx2 set of (x,y) coordinates of points on the ellipse
%         
%
mu = mu(:);  % make it a column vector
x0 = parameters(1);
y0 = parameters(2);
a = parameters(3);
b = parameters(4);
x = x0 + a*sinh(log(abs(mu)+1)).*sign(mu);
y = y0 + b*cosh(log(abs(mu)+1));
point = [x,y];



