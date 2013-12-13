function s = arclength(dfunc, u1, u2)
%
% arclength.m, (c) Matthew Roughan, 2013
%
% created: 	Mon Nov 25 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% ARCLENGTH calculates the length along a curve by integration from u1 to u2
%
%
% INPUTS:
%         func = a function providing a parametric description of a curve 
%                i.e., points on the curve are defined by
%                         [x,y] = func(u)
% 
%         dfunc = derivatives of the function with respect to u
%         u1    = vector of locations along curve
%         u2    = vector of locations along curve
%         
%         size(u1) == size(u2)
%         
%  NB: assumes func and dfunc output Nx2 matrix of points
%
% OUTPUTS:        
%         s     = arc lengths, from u1 to u2
%                           size(s) = size(u1)
%
%

if (~isa(dfunc, 'function_handle'))
  error('dfunc must be a function handle');
end
if (length(u1) == 1 || length(u2) == 1 || length(u1) == length(u2) )
else
  error('u1 and u2 must be the same length, or one can be a scalar');
end
  
g = @(x) sqrt(sum(dfunc(x).^2, 2));
for i=1:length(u1)
  s(i) = quad(g, u1(i), u2(i));
end
 