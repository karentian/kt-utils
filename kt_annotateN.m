function kt_annotateN(n)
% function kt_annotateN(n)

% Annotates n = number of subjects
% To the bottom right corner of a figure
% n scalar with n 

xl = xlim;
yl = ylim;
nStr = sprintf('n = %d',n);
nStrTxt = text(0.945*xl(2),yl(1)+0.01,nStr,'HorizontalAlignment','right','VerticalAlignment','bottom');
nStrTxt.FontSize = 14;
nStrTxt.FontName = 'Helvetica-Light';
