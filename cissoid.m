function [x,y] = cissoid(a, t)
%
% cissoid.m, (c) Matthew Roughan, 2013
%
% created: 	Tue Dec 10 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% CISSOID of Dioclese
%   which is the roulette of one parabolas vertex when the parabola is rolled against another
%        http://en.wikipedia.org/wiki/Cissoid_of_Diocles
%
% INPUTS:
%       a = parameter of the curve  
%       theta = vector of points on the curve
%         
% OUTPUTS:        
%       [x,y] = Cartesian coordinates of points along the curve  
%         
%
%

y = -2*a*t.^2 ./ (1 + t.^2);
x = 2*a*t.^3 ./ (1 + t.^2);
