%
% add in the path to the package
%    http://code.google.com/p/elliptic/
% or otherwise
%    use numerical integration to compute
%
% by default assume you don't have the elliptic integral package
elliptical_int_path = '';
debug = 0;
% uncomment the following, and put in the correct path if you do have the package
% elliptical_int_path = '~/src/matlab/elliptic';
if (exist([elliptical_int_path '/elliptic12.m'], 'file'))
  path(path,elliptical_int_path)
  elliptic_available = 1;
  if (debug)
   fprintf('elliptic integral code available.\n');
  end
else
  elliptic_available = 0;
  if (debug)
    fprintf('elliptic integral code unavailable, using numerical integration instead.\n');
  end
end

% 
% but Matlab R2013b apparently has an elliptical integral calculation 
%       http://www.mathworks.com.au/help/symbolic/elliptice.html
% so we can replace this bit when we have the latest version and have
% a chance to test it
%
