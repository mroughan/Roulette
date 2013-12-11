%
% roulette1_animate.m, (c) Matthew Roughan, 2013
%
% created: 	Tue Nov 26 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% ROULETTE1_ANIMATE 
%        do some animations of roulettes
%
%   
%
%
clear;
common;
plotdir = 'Animations/'
suffix = 'gif';
device = '-dgif';

% 
% ellipse - undulary animation
% 

% define and draw the ellipse
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

% calculate the exact undulary
[x_undulary,y_undulary] = undulary(a, b, -10:0.1:10);
plot(x_undulary,y_undulary, 'm-');
plot(sqrt(a^2-b^2),b, 'bo', 'linewidth', 5)

% use roulette1 to calculate the roulette
M = [x, y];
f = @(t) ellipse(parameters, t);
F = @(t) ellipsed(parameters, t);
s = 2:2:14; 
[u, Md] = roulette1(f, F, [sqrt(a^2-b^2),b], -pi/2, s);
% plot the focus at the points its been rolled to
plot(Md(:,1), Md(:,2), 'go', 'linewidth', 5)

% points_u = ellipse(parameters, u);
% x = points_u(:,1);
% y = points_u(:,2);
% plot(x,y, 'b+')

% draw the rolled ellipse
for i=1:length(s)
  [u, Md] = roulette1(f, F, M, -pi/2, s(i));
  plot(Md(:,1), Md(:,2), 'r', 'linewidth', 1)
end

% print out the plot
set(gca, 'xlim', [-5 15]);
set(gca, 'ylim', [0 5]);
set(gcf, 'PaperUnits', 'centimeters')
set(gcf, 'PaperPosition', [0 0 40 10])
filename = sprintf('%s/roulette_ellipse%s.%s', plotdir, version, suffix)
print(device, filename);
