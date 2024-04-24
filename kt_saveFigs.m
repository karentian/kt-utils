function kt_saveFigs(figTitle, s)

if s.saveFigs
    export_fig(gcf,sprintf('%s/%s.%s', s.figDir, figTitle, s.figType), '-transparent','-p10')
end