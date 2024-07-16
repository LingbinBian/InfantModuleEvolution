% MANIP Calculate functional connectivity
%
% Version 1.0
% 25-Jun-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

scan_dir='PA';
scan=2;
positive=1;   % 1: only positive connectivity
N_roi=400;   % number of ROI

if scan==1
    list=dir('../data/400ROI_AP/*.mat');
else
    list=dir('../data/400ROI_PA/*.mat');
end
N_sub=length(list);   % number of subjects

idxtu = triu(ones(N_roi), 1);    % upper triangular one matrix
FC_feature = zeros(N_sub, sum(idxtu, 'all'));
FC_name=cell(N_sub,1);

for i=1:N_sub
    fprintf('subject = %d\n',i);
    struct_ROI=load(['../',num2str(N_roi),'ROI_',scan_dir,'/',list(i).name]);
    ROI_name = fieldnames(struct_ROI);
    Brain_ROISignal = getfield(struct_ROI, ROI_name{1}); 
    FC_matrix = corr(Brain_ROISignal);
    FC_feature(i,:) = FC_matrix(idxtu~=0);
    FC_name{i,1}=ROI_name{1,1}(1:end-10);
end

harmonized_feature=harmonization_fc(FC_feature,scan);
%harmonized_feature=FC_feature';
harmonized_feature=harmonized_feature';

FC=cell(N_sub,1);
for i=1:N_sub
    FC=feature2fc(harmonized_feature(i,:),N_roi);
    if positive==1
        FC(FC<0)=0;  % remove negative
        save_path=fullfile(['../data/',num2str(N_roi),'FC_1_',scan_dir,'/',FC_name{i,1}]);
    else 
        save_path=fullfile(['../data/',num2str(N_roi),'FC_',scan_dir,'/',FC_name{i,1}]);
    end
    save(save_path,'FC');
end




