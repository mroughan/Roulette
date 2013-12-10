function derivatives = parabolad(parameters, x)
%
% parabola.m, (c) Matthew Roughan, 2013
%
% created: 	Tue Nov 26 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% PARABOLAD calculates derivatives of [x,y] WRT to x for the
%           parabola with vertical axis of symmetry
%                    y = (x-h).^2 / (4*f) + k
%
% INPUTS:
%         parameters = [x0, y0, f]
%                           (x0,y0) = coordinate of vertex
%                               f = focal length			   
%         x          = vector of x-ordinates
%         
% OUTPUTS:        
%         derivatives = Nx2 vector of derivatives at points 
%                        [dx,dy] = are derivatives WRT theta at the points on the ellipse
%
%

x = x(:);
x0 = parameters(1);
y0 = parameters(2);
f = parameters(3);
dx = ones(size(x));
dy = (x-x0) / (2*f);
derivatives = [dx,dy];
