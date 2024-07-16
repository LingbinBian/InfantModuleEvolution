function [data_harmonized] = harmonization_fc(feature,scan)
% This function harmonizes the feature of FC
% Input: feature,N_subj by L,where L is the length of FC features
%
% Version 1.0
% 25-Jun-2023
% Copyright (c) 2023, Lingbin Bian

if scan==1
    load('subj_info_ap.mat');
else
    load('subj_info_pa.mat');
end
N_subj=length(subj_info);

dat=feature'; % L by N_subj
[N_feature,N_subj]=size(dat);
for i=1:N_feature
    for j=1:N_subj
        if isnan(dat(i,j))
            dat(i,j)=0;
        end
    end
end

batch=cell(N_subj,1);
sex=cell(N_subj,1);
age=zeros(N_subj,1);
% -------------------------------------------------------------------------
for i=1:N_subj
    batch{i,1}=subj_info{i,4};  % site
    sex{i,1}=subj_info{i,3}; % sex
    age(i,1)=subj_info{i,2}; % age
end

batch=categorical(batch);
batch=dummyvar(batch);
batch=batch(:,1);

for i=1:N_subj
    if batch(i)==0
        batch(i)=2;
    end
end

sex=categorical(sex);
sex=dummyvar(sex);

mod = [age sex(:,2)];

data_harmonized = combat(dat, batch, mod, 1);

end