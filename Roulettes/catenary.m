function [x_cat, y_cat] = catenary(parameters, x)
%
% catenary.m, (c) Matthew Roughan, 2013
%
% created: 	Tue Dec 10 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% CATENARY: draw a catenary (a hanging chain) in the parameterisation
%           corresponding to it as a roulette of a parabola
%             (see parabola.m and parabolad.m)
%
%           y = f cosh(x/f)
%
% INPUTS:
%           parameters = parameters of generating parabola = [x0, y0, f]
%                          (x0,y0) ignored
%                          f = focal length of parabola used to generate roulette
%           x = x coordinates of the input curve (being rolled), i.e., the parabola
%         
% OUTPUTS:        
%           [x_cat,y_cat] = points on the catenary
%         
%
%

% process inputs
x = x(:);
x0 = parameters(1);
y0 = parameters(2);
f = parameters(3);
t = asinh(x/(2*f));

% calculate catenary
x_cat = f*t;
y_cat = f*cosh(t);

