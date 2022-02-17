%% Make plots for turn analysis
%
% Charles Xu @ UCSD, 20220216, adopted from TEMPTRY_ALTVIEW.m by Alex
% Johnson
%
% This code is intended for completing all
%
% 
%% Main

%% Loop across all recordings
for i = 106:107 % remember to expand the range to cover all.. i = length(TurnAnalysis.IsRightTurn_IntOnly)
    rec = TurnAnalysis.IsRightTurn_IntOnly{1,i};
    firstAlt = zeros(0,length(rec(1,:))-1);
    secondAlt = zeros(0,length(rec(1,:))-2);
    
    %% First order alternation
    for j = 1:size(rec,1)
        for k = 2:size(rec,2)
            if xor(rec(j,k) == 1, rec(j,k-1) == 1)
                firstAlt(j,k-1) = 1;
            else
                firstAlt(j,k-1) = 0;
            end
        end
    end
    
    %% Second order alternation
    for j = 1:size(firstAlt,1)
        for k = 2:size(firstAlt,2)
            if xor(firstAlt(j,k) == 1, firstAlt(j,k-1) == 1)
                secondAlt(j,k-1) = 1;
            else
                secondAlt(j,k-1) = 0;
            end
        end
    end
    
    figure
    subplot(3,1,1)
    imagesc(rec)
    subplot(3,1,2)
    imagesc(firstAlt)
    subplot(3,1,3)
    imagesc(secondAlt)
end