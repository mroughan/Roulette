function rms_error = al_test(parameters, func, funcd, range, u0, doplots, output_precision)
%
% al_test.m, (c) Matthew Roughan, 2013
%
% created: 	Thu Dec 12 2013 
% author:  	Matthew Roughan 
% email:   	matthew.roughan@adelaide.edu.au
% 
% AL_TEST tests a single instance of a curves arclength
%
% INPUTS:
%         parameters = vector of curve parameters
%         func       = function that calculates the points on the curve, and arclengths
%                       [points, s] = func(parameters, u)
%         funcd      = function that calculates derivatives for the curve
%                       derivatives = ellipsed(parameters, u)
%         range      = [u_min, u_max] values of u needed in tests/plots
%         u0         = the point from which to calculate arclengths
%         doplots    = 0, don't do a plot
%                    > 0, use as the figure number for plots
%         output_precision = precision to use for diagnostics
%
% OUTPUTS:        
%        rms_error   = root mean square error in numerical vs theoretical arclength
%                      calculations
%
%


% start by plotting the curve over the range specified
if (doplots > 0)
  m = 1000;
  du = diff(range)/m;
  u = range(1):du:range(2);
  points = func(parameters, u);
  x = points(:,1);
  y = points(:,2);
  figure(doplots);
  hold off
  plot(x, y);
  axis equal
end

% check the arclengths at 10 points
m = 10;
du = diff(range)/m;
u = range(1):du:range(2);
[points, ell] = func(parameters, u);

if (doplots > 0)
  x = points(:,1);
  y = points(:,2);
  figure(doplots);
  hold on
  plot(x,y, 'ro', 'linewidth', 5)

  % also plot the derivatives as a visual check
  D = funcd(parameters, u);
  dx = D(:,1);
  dy = D(:,2);
  plot([x, x+dx]', [y, y+dy]', 'r', 'linewidth', 1);
end

for i=1:length(u)
  s = arclength(@(t) funcd(parameters, t), u0, u(i));
  difference(i) =   ell(i)-s;
  
  if (output_precision > 0)
    fprintf('numerical value = %*.*f,  theoretical value = %*.*f,   diff = %*.*f\n', ...
	    output_precision+4, output_precision, s, ...
	    output_precision+4, output_precision, ell(i), ...
	    output_precision+4, output_precision, difference(i));
  end
  
  if (doplots > 0)
    figure(doplots);
    text(x(i),y(i), sprintf('s = %.2f', s));
  end
end

rms_error = sqrt(mean( difference.^2 ));