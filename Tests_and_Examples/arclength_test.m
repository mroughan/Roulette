%
% arclength_test.m, (c) Matthew Roughan, 2013
%
% created: 	Mon Nov 25 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% ARCLENGTH_TEST 
%
% tests of arclength calculation by numerical integration and theoretical results
%    see al_test.m for details of actual tests

clear;
path(path,'../');
common;
output_precision = 9;

% 
% test a circle
% 
fprintf('\n\ncircle\n');
r = 2;
parameters = [0, r, r, r]; 
range = [-pi pi];
u0 = -pi/2;
doplots = 1;
rms_error_circle = al_test(parameters, @ellipse, @ellipsed, range, u0, doplots, output_precision)

% 
% test ellipse arclengths
%
fprintf('\n\nellipse\n');
a = 2;
b = 1;
parameters = [0, b, a, b];
range = [-pi pi];
u0 = -pi/2;
doplots = 2;
rms_error_ellipse = al_test(parameters, @ellipse, @ellipsed, range, u0, doplots, output_precision)


% 
% now try a parabola
% 
fprintf('\n\nparabola\n');
x0 = 1;    % axis of symmetry is y-axis
f  = 1.25; % focal length
y0 = 0;    % vertex at the origin
parameters = [x0, y0, f];
range = [-4 4];
u0 = x0;
doplots = 3;
rms_error_parabola = al_test(parameters, @parabola, @parabolad, range, u0, doplots, output_precision)

focus_x = x0;
focus_y = y0 + f;
plot(focus_x, focus_y, 'o');
plot([x0 focus_x], [y0 focus_y], '--', 'linewidth', 2);



% 
% now try a hyperbola
% 
fprintf('\n\nhyperbola\n');
a = 1;
b = 1.5;
x0 = 1;
y0 = -b;
parameters = [x0, y0, a, b];
u0 = 0;
range = [-5 5];
doplots = 4;
rms_error_hyperbola = al_test(parameters, @hyperbola, @hyperbolad, range, u0, doplots, output_precision)

e = sqrt(a^2 + b^2)/b; % eccentricity
c = b*e; % distance from centre to focus
focal = c - b; % focal length, which gives y coordinate of focal point

focus_x = x0;
focus_y = y0 + c;
plot(focus_x, focus_y, 'o');
plot([x0 focus_x], [y0 focus_y], '--', 'linewidth', 2);

XX = get(gca, 'xlim');
YY = get(gca, 'ylim');
plot(XX,  (b/a)*(XX-x0)+y0, 'k:')
plot(XX, -(b/a)*(XX-x0)+y0, 'k:')
set(gca, 'ylim', YY);

