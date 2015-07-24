%
% roulette2_test.m, (c) Matthew Roughan, 2013
%
% created: 	Mon Nov 25 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% ROULETTE2_TEST 
%
%
%
clear;
path(path,'../');
common;
 

% 
% epicycloid (roll one circle outside another)
% 
theta = 0:pi/100:2*pi;
k = 5.5;
[p,q] = rat(k);
k = p/q;
r = 1;
R = k*r;
a = r;
b = r;
parameters1 = [0, r,  r, r];  % go round the 1st circle in the opposite direction
points1 = ellipse(parameters1, theta);
parameters2 = [0, -R, R, R]; 
points2 = ellipse(parameters2, theta);
figure(1) 
hold off
plot(0,0);
hold on
plot(points1(:,1), points1(:,2), 'b');
plot(points2(:,1), points2(:,2), 'k');
axis equal

% calculate points on the cycloid exactly
phi0 = pi/2;
phi = 0:pi/100:2*p*pi;
[x_cyc, y_cyc, k] = epicycloid(R, r, phi0, phi);
plot(x_cyc, y_cyc-R, 'r-');

% calculate them using roulette2
s = 0:1/5:70;
[u, Md] = roulette2(@(t) ellipse(parameters1, t), @(t) ellipsed(parameters1, t), ...
		    @(t) ellipse(parameters2, t), @(t) ellipsed(parameters2, t), ...
		    [0,0], pi/2, pi/2, s);
plot(Md(:,1), Md(:,2), 'g--')

% % show the rotating ellipses that make up the points
% points_u = ellipse(parameters, u);
% x = points_u(:,1);
% y = points_u(:,2);
% plot(x,y, 'b+')
% for i=1:length(s)
%   [u, Md] = roulette1(f, F, M, -pi/2, s(i));
%   plot(Md(:,1), Md(:,2), 'r')
% end


% 
% hypocycloid (roll one circle inside another)
% 
theta = 0:pi/100:2*pi;
k = 5.5;
[p,q] = rat(k);
k = p/q;
r = 1;
R = k*r;
a = r;
b = r;
parameters1 = [0, -r, r, r]; 
points1 = ellipse(parameters1, theta);
parameters2 = [0, -R, R, R]; 
points2 = ellipse(parameters2, theta);
figure(2) 
hold off
plot(0,0);
hold on
plot(points1(:,1), points1(:,2), 'b');
plot(points2(:,1), points2(:,2), 'k');
axis equal

% calculate points on the cycloid exactly
phi0 = pi/2;
phi = 0:pi/100:2*p*pi;
[x_cyc, y_cyc, k] = hypocycloid(R, r, pi/2, phi);
plot(x_cyc, y_cyc-R, 'r-');

% calculate them using roulette2
s = 0:1/5:70;
[u, Md] = roulette2(@(t) ellipse(parameters1, t), @(t) ellipsed(parameters1, t), ...
		    @(t) ellipse(parameters2, t), @(t) ellipsed(parameters2, t), ...
		    [0,0], -pi/2, pi/2, s);
plot(Md(:,1), Md(:,2), 'g--')

% % show the rotating ellipses that make up the points
% points_u = ellipse(parameters, u);
% x = points_u(:,1);
% y = points_u(:,2);
% plot(x,y, 'b+')
% for i=1:length(s)
%   [u, Md] = roulette1(f, F, M, -pi/2, s(i));
%   plot(Md(:,1), Md(:,2), 'r')
% end


% 
% Cissoid of Diocles
% 
theta = -2*pi:pi/100:2*pi;
a = 1;
parameters1 = [0, 0, -1]; 
points1 = parabola(parameters1, theta);
parameters2 = [0, 0, 1]; 
points2 = parabola(parameters2, theta);
figure(3) 
hold off
plot(0,0);
hold on
plot(points1(:,1), points1(:,2), 'b');
plot(points2(:,1), points2(:,2), 'k');
axis equal

% calculate points on the cissoid exactly
u = -5:0.01:5;
[x_c, y_c] = cissoid(a, u);
plot(x_c, y_c, 'r-');



% calculate them using roulette2
s = -20:0.1:20;
[u, Md] = roulette2(@(t) parabola(parameters1, t), @(t) parabolad(parameters1, t), ...
		    @(t) parabola(parameters2, t), @(t) parabolad(parameters2, t), ...
		    [0,0], 0, 0, s);
plot(Md(:,1), Md(:,2), 'g--')

% % show the rotating parabolas that make up the points
% points_u = parabola(parameters, u);
% x = points_u(:,1);
% y = points_u(:,2);
% plot(x,y, 'b+')
% for i=1:length(s)
%   [u, Md] = roulette1(f, F, M, -pi/2, s(i));
%   plot(Md(:,1), Md(:,2), 'r')
% end
