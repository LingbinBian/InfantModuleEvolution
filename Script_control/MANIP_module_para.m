% MANIP Intra-module & inter module connectivity analysis
%
% Version 1.0
% 14-Sep-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

N_roi=100;  % number of ROI
scan=1;   % 1: AP, 2: PA

if scan==1
    scan_dir='AP';
    load(['../results/','roi_',num2str(N_roi),'_',scan_dir,'/grouplevel_data_AP.mat']);
    load(['../results/','roi_',num2str(N_roi),'_1_',scan_dir,'/labels_AP.mat']);
    esti_label=label_AP;
else
    scan_dir='PA';
    load(['../results/','roi_',num2str(N_roi),'_',scan_dir,'/grouplevel_data_PA.mat']);
    load(['../results/','roi_',num2str(N_roi),'_1_',scan_dir,'/labels_PA.mat']);
    esti_label=label_PA;
end

N_subj=length(subj_info);
N_window=length(count_subj);   % number of ege window

esti_mean=cell(N_subj,N_window);
esti_variance=cell(N_subj,N_window);


% Estimate the module parameters, mean and variance
for j=1:N_window
    for i=1:count_subj(1,j)   
        [esti_mean{i,j},esti_variance{i,j}]=local_para(esti_label(:,j),adj{i,j},local_t,K_min,S);
    end
end






