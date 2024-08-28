function kt_saveFigs(figTitle, s)

% use export_fig for placing linked pdfs into ai 
% otherwise saveas is simpler for progress figures 
if ~exist(s.figDir,'dir')
    mkdir(s.figDir)
end

if s.saveFigs
    switch s.figType
        case {'pdf'}
            export_fig(gcf,sprintf('%s/%s.%s', s.figDir, figTitle, s.figType), '-transparent','-p10')
            % exportgraphics(gcf,sprintf('%s/%s.%s', s.figDir, figTitle, s.figType),'ContentType','vector')
        case {'svg'} 
            saveas(gcf,sprintf('%s/%s.%s', s.figDir, figTitle, s.figType))
        case {'png'}
            export_fig(gcf,sprintf('%s/%s.%s', s.figDir, figTitle, s.figType))
    end
end