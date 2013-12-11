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
elliptical_int_path = '/home/mroughan/src/matlab/elliptic';
% uncomment this if you don't have the package
% elliptical_int_path = '';
if (exist('elliptic12.m', 'file'))
  path(path,elliptical_int_path)
  elliptic_available = 1
else
  elliptic_available = 0
end
