function derivatives = hyperbolad(parameters, mu)
%
% hyperbolad.m, (c) Matthew Roughan, 2013
%
% created: 	Mon Nov 25 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% hyperbolad calculates the slopes of tangents to the hyperbola.m WRT to mu
%
% INPUTS:
% INPUTS:
%         parameters = [x0, y0, a, b]
%             (x0, y0) = centre
%             (a,b) such that            (y-y0)^2/b^2 - (x-x0)^2/a^2  = 1
%
%         mu        = Nx1 column vector
%
% OUTPUTS:      
%         derivatives = Nx2 vector of derivatives at points 
%                        [dx,dy] = are derivatives WRT mu at the points on the ellipse
%         
%
mu = mu(:);  % make it a column vector
x0 = parameters(1);
y0 = parameters(2);
a = parameters(3);
b = parameters(4);
dx = a*cosh(log(abs(mu)+1))./(abs(mu)+1);
dy = b*sinh(log(abs(mu)+1)).*sign(mu)./(abs(mu)+1);
derivatives = [dx, dy];  



