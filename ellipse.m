function [point] = ellipse(parameters, theta)
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
%             (x0, y0) = centre
%             (a, b)   = semi-major, and semi-minor axes
%                          a > b         
%         theta        = angles (Nx1 column vector)
%
% OUTPUTS:        
%         p = Nx2 set of (x,y) coordinates of points on the ellipse
%         
%
theta = theta(:);  % make it a column vector
x0 = parameters(1);
y0 = parameters(2);
a = parameters(3);
b = parameters(4);
x = x0 + a*cos(theta);
y = y0 + b*sin(theta);
point = [x,y];


