clear
clc
close all

p=10000;   % length of data
n=10;    
batch = [1 1 1 1 1 2 2 2 2 2]; % Batch variable for the scanner id
dat = randn(p,n); % Random data matrix

age = [82 70 68 66 80 69 72 76 74 80]'; % Continuous variable

sex = [1 2 1 2 1 2 1 2 1 2]'; % Categorical variable (1 for females, 2 for males)
sex = dummyvar(sex);

disease = {'ad'; 'healthy';'healthy';'healthy';'mci';'mci';'healthy'; 'ad'; 'ad';'mci'};
disease = categorical(disease);
disease = dummyvar(disease);

mod = [age sex(:,2) disease(:,2:3)];

data_harmonized = combat(dat, batch, mod, 1);






