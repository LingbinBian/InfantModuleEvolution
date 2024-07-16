clear
clc
close all



N_roi=100;
res=1.5:0.1:2.1;
N_res=7;
label_res=cell(1,7);
for i=1:N_res
label_res{i}=load(['../results/','roi_',num2str(N_roi),'_1_','AP','/',num2str(res(i)),'/grouplevel_data_AP.mat']);
end
