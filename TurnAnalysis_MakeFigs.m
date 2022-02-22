%% Make plots for turn analysis
%
% Charles Xu @ UCSD, 20220216, adopted from TEMPTRY_ALTVIEW.m by Alex
% Johnson
%
% This code is intended for completing all of the plotting of turn analysis
% figures
%
%% Main
clear
close all

% User input
nRecToPlot = 106;
dirWrappedData = '/Users/alveus/Library/Mobile Documents/com~apple~CloudDocs/Collaborate/KindofBlueLab/RSC_DREADDs/Code/TTTWrapper/Dec2021_Compilation.mat'; % Specify full path to the data file, including file name

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

