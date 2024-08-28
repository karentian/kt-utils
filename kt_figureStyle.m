function kt_figureStyle

% adjusts basic fig axis and text styling
box off
hold on
set(gca,'TickDir','out');
ax = gca;
ax.LineWidth = 1.5;
ax.XColor = 'black';
ax.YColor = 'black';
ax.FontSize = 18; % 12


