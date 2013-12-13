%
% an example showing the nodary in its glory
%    (as its probably the hardest one to understand
%

clear;
common;

%
% hyperbola - nodary test
%    see http://en.wikipedia.org/wiki/Hyperbola
a = 1.0;
b = 1.5;
parameters = [0, -b, a, b];
e = sqrt(a^2 + b^2)/b; % eccentricity
c = b*e; % distance from centre to focus
focal = c - b; % focal length, which gives y coordinate of focal point
mu = -10:0.1:10;
points = hyperbola(parameters, mu);
x1 = points(:,1);
y1 = points(:,2);
x2 = points(:,1);
y2 = -2*b-points(:,2);
figure(20)
clf(20,'reset')
hold on
plot(x1, y2);
plot(x2, y2);
axis equal

f = @(t) hyperbola(parameters, t); 
F = @(t) hyperbolad(parameters, t);
M = [x1, y1];
s = [1 2:10 50 100 1000 10000];
s = [-7:-4, -3:0.25:3, 4:7];
for i=1:length(s)
  [u, Md] = roulette1(f, F, M, 0, s(i));
  plot(Md(:,1), Md(:,2), 'r')
end
[u, M1d] = roulette1(f, F, [0,focal], 0, s);
[u, M2d] = roulette1(f, F, [0,-2*b-focal], 0, s);
plot(M1d(:,1), M1d(:,2), 'go')
plot(M2d(:,1), M2d(:,2), 'gd')
points_u = hyperbola(parameters, u);
x = points_u(:,1);
y = points_u(:,2);
plot(x,y, 'b+')
% set(gca, 'xlim', [-6 6]);
% set(gca, 'ylim', [-6 6]);

% % work out asymptotic points for the hyperbola
% scale = 2/sqrt(a^2 + b^2);
% x_lim = (c*b/2)*scale - 0.21*scale;% correction is a rough guess from arclength
% y_lim = (c*a/2)*scale;
% plot(x_lim, y_lim, 'mo', 'linewidth', 5);

% calculate exact curve
%   only works if elliptical integral code is available
[x_nodary,y_nodary,x_lim,y_lim] = nodary(parameters, -10:0.1:10);
figure(20)
plot(x_nodary,y_nodary, 'm--');
plot(x_lim, y_lim, 'ms');
