function [x, y] = catenary(f, t)
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
%           f = focal length of parabola used to generate roulette
%           t = parameters along catenary
%         
% OUTPUTS:        
%           [x,y] = points on the catenary
%         
%
%
x = f*t;
y = f*cosh(t);
