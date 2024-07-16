% MANIP Read MRI .csv file for age and gender

% Version 1.0
% 25-Jun-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

N_AP_F=232;
N_AP_M=201;

subj_info_ap_F=cell(N_AP_F,4);
subj_info_ap_M=cell(N_AP_M,4);

load('subj_info_ap.mat')

N_subj=length(subj_info);
c_F=1;
c_M=1;
for i=1:N_subj
    if subj_info{i,3}=='F'
        subj_info_ap_F{c_F,1}=subj_info{i,1};
        subj_info_ap_F{c_F,2}=subj_info{i,2};
        subj_info_ap_F{c_F,3}=subj_info{i,3};
        subj_info_ap_F{c_F,4}=subj_info{i,4};
        c_F=c_F+1;

    elseif subj_info{i,3}=='M'
        subj_info_ap_M{c_M,1}=subj_info{i,1};
        subj_info_ap_M{c_M,2}=subj_info{i,2};
        subj_info_ap_M{c_M,3}=subj_info{i,3};
        subj_info_ap_M{c_M,4}=subj_info{i,4};
        c_M=c_M+1;
    end

end


save_path=fullfile('../Script_control/subj_info_ap_F');
save(save_path,'subj_info_ap_F');

save_path=fullfile('../Script_control/subj_info_ap_M');
save(save_path,'subj_info_ap_M');


% -------------------------------------------------------------------------
clear
clc
close all

N_PA_F=237;
N_PA_M=201;

subj_info_pa_F=cell(N_PA_F,4);
subj_info_pa_M=cell(N_PA_M,4);


load('subj_info_pa.mat')

N_subj=length(subj_info);
c_F=1;
c_M=1;
for i=1:N_subj
    if subj_info{i,3}=='F'
        subj_info_pa_F{c_F,1}=subj_info{i,1};
        subj_info_pa_F{c_F,2}=subj_info{i,2};
        subj_info_pa_F{c_F,3}=subj_info{i,3};
        subj_info_pa_F{c_F,4}=subj_info{i,4};
        c_F=c_F+1;

    elseif subj_info{i,3}=='M'
        subj_info_pa_M{c_M,1}=subj_info{i,1};
        subj_info_pa_M{c_M,2}=subj_info{i,2};
        subj_info_pa_M{c_M,3}=subj_info{i,3};
        subj_info_pa_M{c_M,4}=subj_info{i,4};
        c_M=c_M+1;
    end

end


save_path=fullfile('../Script_control/subj_info_pa_F');
save(save_path,'subj_info_pa_F');

save_path=fullfile('../Script_control/subj_info_pa_M');
save(save_path,'subj_info_pa_M');
































