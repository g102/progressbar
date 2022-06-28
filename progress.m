function out = progress(fraction, text)
% Writes a text progress bar to the console
%
% Syntax: nb = progress(fraction, text)
%
% Input:
%  - fraction: number between 0 and 1 (where 1 means the process has ended)
%  - text: label to display beside the progress bar
%
% Output:
%  - out: number of bytes printed, can be used to delete the progress bar
%         with fprintf(repmat('\b', 1, out));
% 
% Usage:
%  - in a for loop, write progress(j/maxiter, 'text') to display a progress
%  bar:
%  >> j = 2; maxiter = 10; progress(j/maxiter);
%  [====                ] 20.0%
%
%  - subsequent calls to the progress bar will delete the last `out' bytes,
%    if something else has been printed to stdout this will delete that and
%    not the progress bar
%  - avoid this by typing `progress reset'

persistent nb
persistent lastUpdate

if ischar(fraction) || isstring(fraction)
	if strcmp(fraction, 'reset')
		clearvars('nb', 'lastUpdate');
		return
	else
		error('Input 1 must either be a scalar or the string "reset"');
	end
end

if isempty(nb)
	nb = 0;
end
if isempty(lastUpdate)
	lastUpdate = -inf;
end

if ~exist('text', 'var')
	text = '';
elseif ~isempty(text)
	text = [strtrim(char(text)), ' '];
end

nseg = 20;
bar = repmat(' ', 1, nseg);
for jj = 1:nseg
	if fraction >= 1/nseg * jj
		bar(jj) = '=';
	elseif fraction >= 1/nseg * (jj - 1/2)
		bar(jj) = '-';
	else
		bar(jj) = ' ';
	end
end	

if abs(now - lastUpdate) * 24 * 60 * 60 > 1/30 || fraction == 1
	% if it's been at least .1s since last update then print to screen
	fprintf(repmat('\b', 1, nb));
	nb = fprintf('%s[%s] %.1f%%', text, bar, 100*fraction);
	out = nb;
	lastUpdate = now;
	if fraction == 1
		fprintf('\n');
		nb = 0;	
	end
else
	out = nb;
end

