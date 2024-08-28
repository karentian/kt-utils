function txt = kt_annotateStats(x,y,stars)
% function txt = kt_annotateStats(x,y,stars)

% Draws n.s. and significance stars (or other supplied text) on figure at
% position x,y
% Inputs: 
%   x: x position
%   y: y position, max(fh.YLim) for top of figure 
%   stars: string, ns, *, **, *** or alternative text
% Ouputs: 
%   txt: text handle 

if contains(stars,'*')
    txt = text(x,y,stars,'EdgeColor','none',...
    'FontSize',20,'HorizontalAlignment','center','VerticalAlignment','Bottom','FontName','Helvetica'); % Times, make bigger 
elseif strcmp(stars,'ns')
    txt = text(x,y,'n.s.','EdgeColor','none',...
        'FontSize',14,'HorizontalAlignment','center','VerticalAlignment','Bottom','FontName','Helvetica');
else % any alternative text 
    txt = text(x,y,stars,'EdgeColor','none',...
        'FontSize',14,'HorizontalAlignment','center','VerticalAlignment','Bottom','FontName','Helvetica');
end


