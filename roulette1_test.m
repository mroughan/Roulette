%
% roulette1_test.m, (c) Matthew Roughan, 2013
%
% created: 	Mon Nov 25 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% ROULETTE1_TEST 
%
%
%
clear;
common;
plotdir = '/home/mroughan/Reports/CatenaryMonograph/Figs/';

% 
% ellipse - undulary test
% 
a = 2;
b = 1.5;
parameters = [0, b, a, b]; 
theta = 0:pi/100:2*pi;
points = ellipse(parameters, theta);
x = points(:,1);
y = points(:,2);
figure(1) 
hold off
plot(x, y);
hold on
axis equal

f = @(t) ellipse(parameters, t);
F = @(t) ellipsed(parameters, t);
M = [x, y];
s = 0:0.4:14;
[u, Md] = roulette1(f, F, [sqrt(a^2-b^2),b], -pi/2, s);
plot(Md(:,1), Md(:,2), 'go')
points_u = ellipse(parameters, u);
x = points_u(:,1);
y = points_u(:,2);
plot(x,y, 'b+')
for i=1:length(s)
  [u, Md] = roulette1(f, F, M, -pi/2, s(i));
  plot(Md(:,1), Md(:,2), 'r')
end

% need to calculate and plot
[x_undulary,y_undulary] = undulary(a, b, -10:0.1:10);
plot(x_undulary,y_undulary, 'm--');


set(gcf, 'PaperUnits', 'centimeters')
set(gcf, 'PaperPosition', [0 0 20 20])
filename = sprintf('%s/roulette_ellipse%s.%s', plotdir, version, suffix)
print(device, filename);



% 
% parabola - catenary test
% 
focus = 1.4;
parameters = [0, 0, focus];
mu = -4:0.1:4;
points = parabola(parameters, mu);
x1 = points(:,1);
y1 = points(:,2);
figure(2) 
hold off
plot(x1, y1);
hold on
axis equal

f = @(t) parabola(parameters, t); 
F = @(t) parabolad(parameters, t);
M = [0, focus];
s = [-8:8];
for i=1:length(s)
  [u, Md] = roulette1(f, F, M, 0, s(i));
  plot(Md(:,1), Md(:,2), 'r')
end
[u, Md] = roulette1(f, F, [0,focus], 0, s);
plot(Md(:,1), Md(:,2), 'go')
points_u = parabola(parameters, u);
x = points_u(:,1);
y = points_u(:,2);
plot(x,y, 'b+')
set(gca, 'xlim', [-6 6]);
set(gca, 'ylim', [0 12]);

% calculate exact curve
u = mu/focus;
[x_cat,y_cat] = catenary(focus,  u);
figure(2)
plot(x_cat, y_cat, 'm--');








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
figure(3) 
hold off
plot(x1, y2);
plot(x2, y2);
hold on
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
[x_nodary,y_nodary] = nodary(a, b, -10:0.1:10);
figure(3)
plot(x_nodary,y_nodary, 'm--');

k = cos(atan(a/b));
M = k^2;
[Fc,Ec,Zc] = elliptic12(pi/2, M);
x_lim1 = b + c*((1-M)*Fc - Ec);
x_lim2 = -b + c*((1-M)*Fc - Ec);
y_lim = a;
plot([x_lim1 -x_lim1 x_lim2 -x_lim2], [y_lim y_lim -y_lim -y_lim], 'kd');

%
% do a cyclcoid, http://en.wikipedia.org/wiki/Cycloid
% 
r = 1;
a = r;
b = r;
parameters = [0, b, a, b]; 
theta = 0:pi/100:2*pi;
points = ellipse(parameters, theta);
x = points(:,1);
y = points(:,2);
figure(4) 
hold off
plot(x, y);
hold on
axis equal


f = @(t) ellipse(parameters, t);
F = @(t) ellipsed(parameters, t);
M = [x, y];
s = 0:0.4:14;
[u, Md] = roulette1(f, F, [0,0], -pi/2, s);
plot(Md(:,1), Md(:,2), 'go')
points_u = ellipse(parameters, u);
x = points_u(:,1);
y = points_u(:,2);
plot(x,y, 'b+')
for i=1:length(s)
  [u, Md] = roulette1(f, F, M, -pi/2, s(i));
  plot(Md(:,1), Md(:,2), 'r')
end

% calculate points on the cycloid exactly
theta = 0:pi/100:5*pi;
[x_cyc, y_cyc] = cycloid(r, 1, theta);
plot(x_cyc, y_cyc, 'm--');
plot(x_cyc, y_cyc, 'm--');


%
% do an curtate cyclcoid (trochoid), http://en.wikipedia.org/wiki/Trochoid
% 
r = 1;
a = r;
b = r;
parameters = [0, b, a, b]; 
theta = 0:pi/100:2*pi;
points = ellipse(parameters, theta);
x = points(:,1);
y = points(:,2);
figure(5) 
hold off
plot(x, y);
hold on
axis equal


f = @(t) ellipse(parameters, t);
F = @(t) ellipsed(parameters, t);
M = [x, y];
s = 0:0.4:14;
gamma = 0.7;
[u, Md] = roulette1(f, F, [0,(1-gamma)*b], -pi/2, s);
plot(Md(:,1), Md(:,2), 'go')
points_u = ellipse(parameters, u);
x = points_u(:,1);
y = points_u(:,2);
plot(x,y, 'b+')
for i=1:length(s)
  [u, Md] = roulette1(f, F, M, -pi/2, s(i));
  plot(Md(:,1), Md(:,2), 'r')
end

% calculate points on the cycloid exactly
theta = 0:pi/100:5*pi;
[x_cyc, y_cyc] = cycloid(r, gamma, theta);
plot(x_cyc, y_cyc, 'm--');


%
% do an prolate cyclcoid (trochoid), http://en.wikipedia.org/wiki/Trochoid
% 
r = 1;
a = r;
b = r;
parameters = [0, b, a, b]; 
theta = 0:pi/100:2*pi;
points = ellipse(parameters, theta);
x = points(:,1);
y = points(:,2);
figure(6) 
hold off
plot(x, y);
hold on
axis equal

f = @(t) ellipse(parameters, t);
F = @(t) ellipsed(parameters, t);
M = [x, y];
s = 0:0.4:14;
gamma = 1.25;
[u, Md] = roulette1(f, F, [0,(1-gamma)*b], -pi/2, s);
plot(Md(:,1), Md(:,2), 'go')
points_u = ellipse(parameters, u);
x = points_u(:,1);
y = points_u(:,2);
plot(x,y, 'b+')
for i=1:length(s)
  [u, Md] = roulette1(f, F, M, -pi/2, s(i));
  plot(Md(:,1), Md(:,2), 'r')
end

% calculate points on the cycloid exactly
theta = 0:pi/100:5*pi;
[x_cyc, y_cyc] = cycloid(r, gamma, theta);
plot(x_cyc, y_cyc, 'm--');

