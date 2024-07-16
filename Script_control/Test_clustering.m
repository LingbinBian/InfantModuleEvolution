% Test Clustering
clear
clc
close all

rng('default');  % For reproducibility
X = [gallery('uniformdata',[10 3],12); ...
    gallery('uniformdata',[10 3],13)+1.2; ...
    gallery('uniformdata',[10 3],14)+2.5];
y = [ones(10,1);2*(ones(10,1));3*(ones(10,1))]; % Actual classes
figure
scatter3(X(:,1),X(:,2),X(:,3),100,y,'filled')
title('Randomly Generated Data in Three Clusters');
T1 = clusterdata(X,5);
figure
scatter3(X(:,1),X(:,2),X(:,3),100,T1,'filled')
title('Result of Clustering');

T2 = clusterdata(X,'Maxclust',20); 
figure
scatter3(X(:,1),X(:,2),X(:,3),100,T2,'filled')
title('Result of Clustering');

