function [mat_secondmax] = mat_secondrow(mat)
% visulize maximum value of the row

[N,M]=size(mat);
mat_secondmax=zeros(N,M);

[a b]=max(mat');

for i=1:N
   mat(i,b(i))=0;
end

[c d]=max(mat');

for i=1:N
   mat_secondmax(i,d(i))=c(i);
end

end

