%% Make plots for turn analysis %%
%
% Charles Xu @ UCSD, 20220216, adopted from TEMPTRY_ALTVIEW.m by Alex
% Johnson
%
% This code is intended for Additional data analysis of turn stats
%
% Run TurnAnalysis_MakeStats.m before running this code
%
%% Main %%

isOutlier = summaryTable;

for n = 5:size(isOutlier,2)
    for m = 1:size(isOutlier,1)
        for i = 1:size(summaryStats{1,4},1)
            if table2array(isOutlier(m,2:4)) == table2array(summaryStats{1,4}(i,1:3))
                if table2array(isOutlier(m,n)) > (table2array(summaryStats{1,4}(i,(n-4)*2-1+4)) + table2array(summaryStats{1,4}(i,(n-4)*2+4))*2)
                    isOutlier(m,n) = {1};
                elseif table2array(isOutlier(m,n)) < (table2array(summaryStats{1,4}(i,(n-4)*2-1+4)) - table2array(summaryStats{1,4}(i,(n-4)*2+4))*2)
                    isOutlier(m,n) = {-1};
                else
                    isOutlier(m,n) = {0};
                end
            end
        end
    end
end

% Save processed data
% save(fullfile(dirWrappedData(1:(end-length('OutlierRecordings.mat'))),'isOutlier')

nAboveFirstAt1 = 0;
nBelowFirstAt1 = 0;
for i = 1:size(isOutlier,1)
	if table2array(isOutlier(i,5)) == 1
        nAboveFirstAt1 = nAboveFirstAt1+ 1;
    elseif table2array(isOutlier(i,5)) == -1
        nBelowFirstAt1 = nBelowFirstAt1+ 1;
    end
end