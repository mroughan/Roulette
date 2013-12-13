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
output_precision = 3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ellipse/undulary test
% 
fprintf('ellipse/undulary test\n');

a = 2;
b = 1.5;
parameters = [0, b, a, b];  % ellipse that just touches at the origin, with semi-major axis
                            % parallel to x-axis: need something different for other orientation
range = [0 2*pi];
doplots = 1;
s = -4:2:14;
u0 = 0;
M = [sqrt(a^2-b^2),b];
[rms_u_error, rms_x_error, rms_y_error] = ...
    rl1_test(parameters, ...
	     @(t) ellipse(parameters, t-pi/2), ...
	     @(t) ellipsed(parameters, t-pi/2), ...
	     @(t) undulary(parameters, t), ...
	     M, range, u0, s, doplots, output_precision)

% print out the plot
figure(doplots+100)
set(gca, 'xlim', [-5 15]);
set(gca, 'ylim', [0 5]);
set(gcf, 'PaperUnits', 'centimeters')
set(gcf, 'PaperPosition', [0 0 40 10])
filename = sprintf('%s/roulette_ellipse%s.%s', plotdir, version, suffix)
print(device, filename);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% parabola - catenary test
% 
fprintf('parabola/catenary test\n');
x0 = 0;
y0 = 0;
focus = 0.7;
parameters = [x0, y0, focus];
range = [-3 3];
doplots = 2;
s = -15:3:15;
u0 = 0;
M = [0, focus];
[rms_u_error, rms_x_error, rms_y_error] = ...
    rl1_test(parameters, ...
	     @(x) parabola(parameters, x), ...                 
	     @(x) parabolad(parameters, x), ...                
	     @(x) catenary(parameters, x), ...
	     M, range, u0, s, doplots, output_precision)

% print out the plot
figure(doplots+100)
set(gca, 'xlim', [-4 4]);
set(gca, 'ylim', [0 4]);
set(gcf, 'PaperUnits', 'centimeters')
set(gcf, 'PaperPosition', [0 0 20 10])
filename = sprintf('%s/roulette_parabola%s.%s', plotdir, version, suffix)
print(device, filename);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% hyperbola/nodary test
% 
fprintf('hyperbola/nodary test\n');
a = 1.0;
b = 1.4;
e = sqrt(a^2 + b^2)/b; % eccentricity
c = b*e; % distance from centre to focus
parameters = [0, -b, a, b];
range_mu = [-5 5]; 
doplots = 3;
s = -10:4:10; 
mu0 = 0;
M = [[0, c-b];
     [0, -b-c]
    ];
[rms_u_error, rms_x_error, rms_y_error] = ...
    rl1_test(parameters, ...
	     @(mu) hyperbola(parameters, mu), ...  
	     @(mu) hyperbolad(parameters, mu), ...   
	     @(mu) nodary(parameters, mu), ...
	     M, range_mu, mu0, s, doplots, output_precision)

% print out the plot
figure(doplots+100)
set(gca, 'xlim', [-2 2]);
set(gca, 'ylim', [0 2]);
set(gcf, 'PaperUnits', 'centimeters')
set(gcf, 'PaperPosition', [0 0 20 10])
filename = sprintf('%s/roulette_hyperbola%s.%s', plotdir, version, suffix)
print(device, filename);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% circle/cycloid test, http://en.wikipedia.org/wiki/Cycloid
% 
fprintf('circle/cycloid tests\n');

r = 2;
% gamma = 1;
% gamma = 0.8; % curtate
gamma = 1.2; % prolate
parameters = [0, r, r, r];  % circle that just touches at the origin, with semi-major axis
                            % parallel to x-axis: need something different for other orientation
range = [0 2*pi];
doplots = 4;
s = -6:2:18;
u0 = 0;
M = [0, r*(1-gamma)];
[rms_u_error, rms_x_error, rms_y_error] = ...
    rl1_test(parameters, ...
	     @(t) ellipse(parameters, t-pi/2), ...
	     @(t) ellipsed(parameters, t-pi/2), ...
	     @(t) cycloid(r, gamma, t), ...
	     M, range, u0, s, doplots, output_precision)

% print out the plot
figure(doplots+100)
set(gca, 'xlim', [-5 15]);
set(gca, 'ylim', [-0.5 4.5]);
set(gcf, 'PaperUnits', 'centimeters')
set(gcf, 'PaperPosition', [0 0 40 10])
filename = sprintf('%s/roulette_cycloid%s_%3.1f.%s', plotdir, version, gamma, suffix)
print(device, filename);


