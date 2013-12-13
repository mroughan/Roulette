function [rms_u_error, rms_x_error, rms_y_error] = ...
    rl1_test(parameters, func, funcd, roulette, M, range, u0, s, doplots, output_precision)
%
% rl1_test.m, (c) Matthew Roughan, 2013
%
% created: 	Thu Dec 12 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% RL1_TEST tests a single instance of a curves arclength
%
%
% INPUTS:
%         parameters = vector of curve parameters
%         func       = function that calculates the points on the curve, and arclengths
%                          e.g., [points, s] = ellipse(parameters, u)
%         funcd      = function that calculates derivatives for the curve
%                          e.g., derivatives = ellipsed(parameters, u)
%         roulette   = function that calculates point on the roulette directly
%                          e.g., [x,y] = undulary(parameters, u)
%         M          = point being traced as curve rolls
%         range      = [u_min, u_max] values of u to be used in plotting the function
%         u0         = point on curve that should touch the origin
%         s          = points at which to draw the roulette in terms of arclength on the original curve
%         doplots    = 0, don't do a plot
%                    > 0, use as the base figure number for plots (uses figuren) and figure(100+n)
%         output_precision = precision to use for diagnostics
%
% OUTPUTS:        
%        rms_errors   = root mean square error in numerical vs theoretical calculations
%
%


% numerical tests
%   compute the roulette at a few given points 'u'
%   also compute arclengths 'ell' for these 'theta'
%   compute the roulette for the 'ell' and compare
m = 20;
du = diff(range)/m;
u = range(1):du:range(2);
u = u(:);
[points, ell] = func(u); 
[p0,ell0] = func(u0);
ell = ell - ell0;
[x_roulette,y_roulette] = roulette(u); % theoretical result
for j=1:size(M,1)
  % allow for multiple foci
  [uout, Md] = roulette1(func, funcd, M(j,:), u0, ell); % numerical result
  x_roulette2(:,j) = Md(:,1);
  y_roulette2(:,j) = Md(:,2);
end
u_error = u - uout;
x_error = x_roulette - x_roulette2;
y_error = y_roulette - y_roulette2;
rms_u_error = sqrt( mean( abs( u_error.^2 ) ) );
rms_x_error = sqrt( mean( abs( x_error.^2 ) ) );
rms_y_error = sqrt( mean( abs( y_error.^2 ) ) );

% plot the results
if (doplots>0)
  figure(doplots)
  clf(doplots,'reset')
  hold on
  plot(x_roulette,y_roulette, 'bo');
  plot(x_roulette2,y_roulette2, 'rx');
  for j=1:size(M,1)
    plot(M(j,1), M(j,2), 'gd');
  end
  axis equal
end

% print out the results
for j=1:size(M,1)
  if (size(M,1) > 1)
    fprintf('   branch %d\n', j)
  end
  for i=1:length(u)
    if (output_precision > 0)
      fprintf('      numerical  = ( %*.*f , %*.*f ),  theoretic = ( %*.*f , %*.*f )\n', ...
	      output_precision+4, output_precision, x_roulette(i,j), ...
	      output_precision+4, output_precision, y_roulette(i,j), ...
	      output_precision+4, output_precision, x_roulette2(i,j), ...
	      output_precision+4, output_precision, y_roulette2(i,j));
    end
  end
end


% if required do a nice plot of the roulette
if (doplots>0)
  
  figure(doplots+100)
  clf(doplots+100,'reset')
  hold on
  axis equal

  % plot the roulette
  m = 100;
  ds = (max(s) - min(s))/m;
  s0 = min(s):ds:max(s);
  for j=1:size(M,1)
    [uout, Md0] = roulette1(func, funcd, M(j,:), u0, s0);
    plot(Md0(:,1), Md0(:,2), 'm-');
    [uout, Md] = roulette1(func, funcd, M(j,:), u0, s); 
    plot(Md(:,1), Md(:,2), 'ro', 'linewidth', 5);
    plot(M(j,1), M(j,2), 'bo', 'linewidth', 5);
  end
  
  % plot the original curve
  m = 100;
  du = diff(range)/m;
  u = range(1):du:range(2);
  u = u(:);
  [points, ell] = func(u); 
  plot(points(:,1), points(:,2), 'b-');
 
  % plot rolled versions of the curve
  for i=1:length(s)
    if (abs(s(i)) > 1.0e-3)
      [uout, Mr] = roulette1(func, funcd, points, u0, s(i)); 
      plot(Mr(:,1), Mr(:,2), 'r-', 'linewidth', 1);
    end
  end
end


