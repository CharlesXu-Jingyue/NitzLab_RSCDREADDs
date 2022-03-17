%% Make stats for turn analysis %%
%
% Charles Xu @ UCSD, 20220216, adopted from TEMPTRY_ALTVIEW.m by Alex
% Johnson
%
% This code is intended for processing all the turn stats and compiling
% into one table
%
% Run this script before other TurnAnalysis scripts
%
%% Main %%
clear
close all

% User input
nRecToPlot = NaN;
dirWrappedData = '/Users/alveus/Library/Mobile Documents/com~apple~CloudDocs/Collaborate/KindofBlueLab/RSC_DREADDs/Results/TurnAnalysis/Data/Dec2021_Compilation.mat'; % Specify full path to the data file, including file name

% Initialization
load(dirWrappedData)
nOfRec = length(TurnAnalysis.IsRightTurn_IntOnly);
fFirstAlt_turn1 = zeros(nOfRec,1);
fFirstAlt_turn2 = zeros(nOfRec,1);
fFirstAlt_turn3 = zeros(nOfRec,1);
fSecondAlt_turn1 = zeros(nOfRec,1);
fSecondAlt_turn2 = zeros(nOfRec,1);
fSecondAlt_turn3 = zeros(nOfRec,1);

%% Loop across all recordings
for i = 1:nOfRec
    % Initialization
    currentRec = TurnAnalysis.IsRightTurn_IntOnly{1,i};
    firstAlt = zeros(size(currentRec,1),size(currentRec,2)-1);
    secondAlt = zeros(size(currentRec,1),size(currentRec,2)-2);
    
    %% Identify first order alternation
    for j = 1:size(currentRec,1)
        for k = 2:size(currentRec,2)
            if xor(currentRec(j,k) == 1,currentRec(j,k-1) == 1)
                firstAlt(j,k-1) = 1;
            end
        end
    end
    
    %% Identify second order alternation
    for j = 1:size(firstAlt,1)
        for k = 2:size(firstAlt,2)
            if xor(firstAlt(j,k) == 1,firstAlt(j,k-1) == 1)
                secondAlt(j,k-1) = 1;
            end
        end
    end
    
    %% Plot Alternation for specified recording
    if i == nRecToPlot
        figure
        subplot(3,1,1)
        imagesc(currentRec)
        subplot(3,1,2)
        imagesc(firstAlt)
        subplot(3,1,3)
        imagesc(secondAlt)
    end
    
    %% Summary stats
    % Frequencies of first and second order alternatios at turns 1 and 2
    fFirstAlt_turn1(i) = sum(firstAlt(1,:))/(size(firstAlt,2));
    fFirstAlt_turn2(i) = sum(firstAlt(2,:))/(size(firstAlt,2));
    fFirstAlt_turn3(i) = sum(firstAlt(3,:))/(size(firstAlt,2));
    fSecondAlt_turn1(i) = sum(secondAlt(1,:))/(size(secondAlt,2));
    fSecondAlt_turn2(i) = sum(secondAlt(2,:))/(size(secondAlt,2));
    fSecondAlt_turn3(i) = sum(secondAlt(3,:))/(size(secondAlt,2));
    
end

%% Get descriptive stats
RecordingNumber = (1:nOfRec).';
RecordingCondition = string(RecCondition);
RotationCondition = cellstr(RotationCondition);
NumberOfPaths = NumPaths;
FirstAltAtTurn1 = fFirstAlt_turn1;
FirstAltAtTurn2 = fFirstAlt_turn2;
FirstAltAtTurn3 = fFirstAlt_turn3;
SecondAltAtTurn1 = fSecondAlt_turn1;
SecondAltAtTurn2 = fSecondAlt_turn2;
SecondAltAtTurn3 = fSecondAlt_turn3;
summaryTable = table(RecordingNumber,...
    RecordingCondition,...
    RotationCondition,...
    NumberOfPaths,...
    FirstAltAtTurn1,...
    FirstAltAtTurn2,...
    FirstAltAtTurn3,...
    SecondAltAtTurn1,...
    SecondAltAtTurn2,...
    SecondAltAtTurn3);

summaryStats = cell(1,4);

summaryStats{1,1} = grpstats(summaryTable,[2,4],{'mean','std'},'DataVars',5:size(summaryTable,2));
summaryStats{1,2} = grpstats(summaryTable,[3,4],{'mean','std'},'DataVars',5:size(summaryTable,2));
summaryStats{1,3} = grpstats(summaryTable,4,{'mean','std'},'DataVars',5:size(summaryTable,2));
summaryStats{1,4} = grpstats(summaryTable,2:4,{'mean','std'},'DataVars',5:size(summaryTable,2));

% Save descriptive statistics
% save(fullfile(dirWrappedData(1:(end-length('Dec2021_Compilation.mat'))),'SummaryTable.mat'),'summaryTable')
% save(fullfile(dirWrappedData(1:(end-length('Dec2021_Compilation.mat'))),'SummaryStatistics.mat'),'summaryStats')
