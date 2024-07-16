function [FC] =feature2fc(feature,N_roi)
% This function transfers the feature to FC
%
% Version 1.0
% 5-July-2023
% Copyright (c) 2023, Lingbin Bian
FC=zeros(N_roi,N_roi);
idxtu = triu(ones(N_roi), 1);
FC(idxtu~=0)=feature(:);
FC=FC+FC'+eye(N_roi,N_roi);

end