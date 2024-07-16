% DEMO Two-sample F-test for equal variances (heighbouring
% modularity using Bayesian hierarchical modelling and group averaging)
%
% Version 1.0
% 18-Oct-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

N_roi=400;
scan=1;

if scan==1
    load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/results/roi_',num2str(N_roi),'_AP.mat']);
else 
    load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/results/roi_',num2str(N_roi),'_PA.mat']);
end

age_range={'0-5 vs 6-11 Month', '3-8 vs 9-14 Month', '6-11 vs 12-17 Month','9-14 vs 15-23 Month','12-17 vs 18-29 Month','15-23 vs 24-36 Month','18-29 vs >36 Month'};

for i=1:7
    % Boxplot
    figure
  
    data=[corre_hier(:,i),corre_ave(:,i)];
    boxplot(data,'Color','k','Symbol','.','OutlierSize',4,'Labels',{'HB', 'GA'})
    
    colors=[0.1 0.7 0.7;1 0.4 0.6];
    h=findobj(gca,'Tag','Box');
    for j=1:length(h)
        patch(get(h(j),'XData'),get(h(j),'YData'),colors(j,:),'FaceAlpha',.5);
    end
    
    title(age_range{i},'fontsize', 12);
    ylabel('Correlation coefficient');
    set(gcf,'unit','centimeters','position',[5 5 8 10])
    set(gca,'Position',[.2 .15 .75 .75]);
    ylim([0,1]); % range of y
    set(gca,'FontSize',12)
    % Two-sample F-test for equal variances
    alpha = 0.05;
    [h, p, ci, stats] = vartest2(corre_hier(:,i),corre_ave(:,i),  'Alpha', alpha);

    if h
        disp('Significant variance difference');
    else
        disp('No significant variance difference');
    end
   
end



