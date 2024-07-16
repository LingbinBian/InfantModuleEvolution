function [mean_size] = community_size(z)
% calculate the mean community size

% Find unique community indices
unique_z = unique(z);

% Calculate the size of each community
size = histc(z, unique_z);

mean_size=mean(size);
% Display the results
% disp('Community sizes:');
% disp(size);

end