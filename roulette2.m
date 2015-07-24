function [u, Md] = roulette2(func1, funcd1, func2, funcd2, M, u1, u2, s)
%
% roulette2.m, (c) Matthew Roughan, 2013
%
% created: 	Mon Nov 25 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% ROULETTE2 
%         Calculates the roulette of one curve with respect to the a second
%         See 
%            "The General Theory of Roulettes", Gordon Walker, National Mathematics Magazine,
%            Vol. 12, No.1, pp.21-26, 1937
%              http://www.jstor.org/stable/3028504
%
% INPUTS:
%         func1 and  func2
%           = are functions providing a parametric description of a curves
%                i.e., points on the curve are defined by
%                         [x,y] = funci(u)
%                it is presumed that the point u1 on curve 1, and u2 on curve 2
%                corresponds to the origin and that the curves touch both as tangents to each
%                other and to the x-axis at this point
%
%         funcd1 and funcd2
%           = derivatives of the function with respect to u (the parameter)
%                    this is used to numerically calculate arclengths
%
%         M = the points we want to follow WRT curve 1 (in the original coordinate system)
%                M = Nx2 array
%
%         u1 and u2
%           = parametric origins of the two curves, i.e., we expect that
%                  x(ui) = 0
%                  y(ui) = 0
%                  dy1/du(u1) = dy2/du(u2) = 0  (the curves should be tangents to each other at the origin)
%                  dxi/du(ui) ~= 0 
%
%         s = argument giving the points at which to calculate the roulette
%             in terms of distance along the curve
%         
% OUTPUTS:        
%         ui = parameters that give curve at the arclenths s for the two curves
%         Md = [x_roulette, y_roulette] = a vector of points on the roulette
%         
%
%

% either
%     M is Nx2, N>1 and s is a scalar; or
%     M = 1x2, and s is a vector
if (size(M,2) ~= 2)
  error('M should be Nx2 for N points to be rolled');
end
if (size(M,1) > 1 & length(s) > 1)
  error(' either calculate for multiple points M, or multiple s, but not both');
end
p = M(:,1); 
q = M(:,2);
N = size(M,1);

s = s(:);
u = zeros(length(s),2);

% find points along the curve at distances s, where
%    s = arclength(funcd, u)
%    u = parameters that give arclengths from origin of s
options = optimset('MaxFunEvals', 1000);
for i=1:length(s)
  f1 = @(t) ( s(i) - arclength(funcd1, u1, t) );
  f2 = @(t) ( s(i) - arclength(funcd2, u2, t) );
  u(i,1) = fzero(f1, s(i), options);
  u(i,2) = fzero(f2, s(i), options);
end
 
% calculate points along the two curves
points1 = func1(u(:,1));
g = points1(:,1);
G = points1(:,2);
points2 = func2(u(:,2));
f = points2(:,1);
F = points2(:,2);

% calculate derivatives WRT u
derivatives1 = funcd1(u(:,1));
dgdu = derivatives1(:,1);
dGdu = derivatives1(:,2);
derivatives2 = funcd2(u(:,2));
dfdu = derivatives2(:,1);
dFdu = derivatives2(:,2);

% calculate derivatives WRT s, using the chain rule, and approximating
du = 1.0e-6;
duds = du ./ arclength(funcd1, u(:,1), u(:,1)+du);
dgds = dgdu .* duds';
dGds = dGdu .* duds';
duds = du ./ arclength(funcd2, u(:,2), u(:,2)+du);
dfds = dfdu .* duds';
dFds = dFdu .* duds';

% calculate the rolled points, when the rolling curve is a line
x =  (p-g).* (dfds.*dgds + dFds.*dGds) + (q-G).*(dfds.*dGds - dFds.*dgds) + f;
y = -(p-g).* (dfds.*dGds - dFds.*dgds) + (q-G).*(dfds.*dgds + dFds.*dGds) + F;
Md = [x, y];

