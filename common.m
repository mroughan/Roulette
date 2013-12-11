colors = [[1 0 0];
	  [1 0.5 0];
	  [1 0.9 0];
	  [0 1 0];
	  [0 1 1];
	  [0 0 1];
	  [0 0.5 0.5];
	  [0.5 0 0.5];
	 ];
device = '-depsc';
suffix = 'eps';
seed = 1;
plotdir = 'Plots';
set(0,'DefaultTextFontsize', 24);
set(0,'DefaultAxesFontsize', 24);
set(0,'DefaultLineLinewidth', 3);
set(0,'DefaultAxesLineWidth', 3); 
version = '';

%
% add in the path to the package
%    http://code.google.com/p/elliptic/
% or otherwise
%    use numerical integration to compute
%

% edit this to give the correct path if you do have the package
elliptical_int_path = '/home/mroughan/src/matlab/elliptic';
% uncomment the following if you don't have the package
%   elliptical_int_path = '';
if (exist([elliptical_int_path '/elliptic12.m'], 'file'))
  path(path,elliptical_int_path)
  elliptic_available = 1;
  fprintf('elliptic integral code available.\n');
else
  elliptic_available = 0;
  fprintf('elliptic integral code unavailable, using numerical integration instead.\n');
end
% 
% but Matlab R2013b apparently has an elliptical integral calculation 
%       http://www.mathworks.com.au/help/symbolic/elliptice.html
% so we can replace this bit when we have the latest version and have
% a chance to test it
%
