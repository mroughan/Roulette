function [x, y] = cycloid(r, gamma, theta)
%
% cycloid.m, (c) Matthew Roughan, 2013
%
% created: 	Tue Dec 10 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% CYCLOID: the result of rolling a circle on a straight line, and tracing a point
%       http://en.wikipedia.org/wiki/Cycloid
%           - if the point is on the perimeter, then standard cycloid
%           - if inside, then it is a curtate cycloid
%           - if outside, then it is a prolate cycloid
%
% INPUTS:
%              r = radius of circle
%          gamma = relative distance of point being traced  
%                        gamma = 1    =>   regular cycloid
%                        gamma < 1    =>   curtate cycloid
%                        gamma > 1    =>   prolate cycloid
%          theta = vector of rolling angles
%         
% OUTPUTS:        
%         [x,y] = vectors of points on the cycloid
%         
%
%
x = r*(theta - gamma*sin(theta));
y = r*(1 - gamma*cos(theta));
