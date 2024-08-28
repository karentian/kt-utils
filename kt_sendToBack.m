function kt_sendToBack(objHandle)

% Sends item in plot (like ref line) to back
% input: object handle

warnState = warning('off','MATLAB:structOnObject');
cleanupObj = onCleanup(@()warning(warnState)); 
Sxh = struct(objHandle);        % Get undocumented properties (you'll get a warning)
clear('cleanupObj')      % Trigger warning reset
Sxh.Edge.Layer = 'back'; % Set ConstantLine uistack