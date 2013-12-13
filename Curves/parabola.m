function [points, s] = parabola(parameters, x)
%
% parabola.m, (c) Matthew Roughan, 2013
%
% created: 	Tue Nov 26 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% PARABOLA 
%         parabola with vertical axis of symmetry
%                    y = (x-x0).^2 / (4*f) + y0
%         note that the parameterisation used for calculating the roulette is 
%              x = 2 f sinh t
%              y = f sinh^2 t
%         so comparing to the roulette requires a parameter conversion
%
% INPUTS:
%         parameters = [x0, y0, f]
%                           (x0,y0) = coordinate of vertex
%                               f = focal length			   
%         x          = vector of x-ordinates
%         
% OUTPUTS:        
%         points = (x,y) 
%         s      = arclengths from the vertex
%
%

x = x(:);
x0 = parameters(1);
y0 = parameters(2);
f = parameters(3);
y = (x-x0).^2 / (4*f) + y0;
points = [x,y];

% arclengths from the vertex
%    http://en.wikipedia.org/wiki/Arc_length#Length_of_an_arc_of_a_parabola
h = (x-x0)/2;
q = sqrt(f.^2 + h.^2);
s = h.*q/f + f*log( (h+q) / f);

