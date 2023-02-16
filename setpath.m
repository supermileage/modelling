function setpath()
%SETPATH Add model folders to the MATLAB filepath
%   Detailed explanation goes here

% Get the location of the model using the function location
[modelPath, ~, ~] = fileparts(mfilename('fullpath'));

% Generate recursive folder paths
folders = genpath(modelPath);
folders = strsplit(folders,';');

% Remove all .git folders and subfolders
rmCount = 0;
for ii = 1:length(folders)
    if contains(folders{ii - rmCount},'.git')
        folders(ii - rmCount) = [];
        rmCount = rmCount + 1;
    end
end

% Add the folders to the MATLAB path
addpath(folders{:});

end

