function [esti_blockmean,esti_blockvariance]=local_para(esti_label,adj,N_window,K_min,S)

% This function estimates block mean and variance.
% 
% Input: esti_grouplabel: group estimation of labels
%        adj: averaged adjacency matrix
%        localmin_t: a vector of time points with respect to local minima
%        K_min: a vector containing number of communities of states
%        S: replication number, simulation number
% Output: esti_blockmean: estimation of block mean, average of mean
%         esti_variance: estimation of block variance, average of variance
%
% Version 1.0
% 23-Feb-2020
% Copyright (c) 2020, Lingbin Bian
% -------------------------------------------------------------------------


N=length(esti_label);

local_parameter=cell(1,N_window);  % each cell is a struct containing model parameters
cell_blockmean=cell(S,N_window);  % a cell containing replications of block mean
cell_blockvariance=cell(S,N_window);  % a cell containing replications of block variance
esti_blockmean=cell(1,N_window);  % estimated block mean at each state
esti_blockvariance=cell(1,N_window);  % estimated block variance at each state


for j=1:N_window
    local_parameter{1,j}=localpara_inference(adj{j},esti_label(:,j),K_min(j),N,S);
end

for j=1:N_window
   for s=1:S
       para=local_parameter{1,j}(s);
       cell_blockmean{s,j}=para.Mean;
       cell_blockvariance{s,j}=para.Vari;
   end
end

Mean_kl=zeros(S,1); % store temporal single mean element of replications 
for t=1:N_window
    for i=1:K_min(t)
        for j=1:K_min(t)
            for s=1:S
                Mean_kl(s,1)=cell_blockmean{s,t}(i,j);
            end
            esti_blockmean{1,t}(i,j)=mean(Mean_kl);
        end
    end
end

Variance_kl=zeros(S,1); % store temporal single variance element of replications
for t=1:N_window
    for i=1:K_min(t)
        for j=1:K_min(t)
            for s=1:S
                Variance_kl(s,1)=cell_blockvariance{s,t}(i,j);
            end
            esti_blockvariance{1,t}(i,j)=mean(Variance_kl);
        end
    end
end


end

