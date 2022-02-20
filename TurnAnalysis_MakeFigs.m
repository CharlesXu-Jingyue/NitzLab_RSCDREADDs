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
% save('SummaryTable.mat','summaryTable')
% save('SummaryStatistics.mat','summaryStats')

%% Make summary figure
figure
set(gcf,'Position',[10 10 1000 1000])

% Row 1 - Alternation at turn 1 on 4 paths
subplot(5,4,1)
bar(table2array(summaryStats{1,1}(1:2:end,4)))
ylim([0 1])
title({'First Order Alternation','at Turn 1 by','Recording Condition','on 4 Paths'})
xticklabels(table2array(summaryStats{1,1}(1:2:end,1)));

subplot(5,4,2)
bar(table2array(summaryStats{1,1}(1:2:end,10)))
ylim([0 1])
title({'Second Order Alternation','at Turn 1 by','Recording Condition','on 4 Paths'})
xticklabels(table2array(summaryStats{1,1}(1:2:end,1)));

subplot(5,4,3)
bar(table2array(summaryStats{1,2}(1:2:end,4)))
ylim([0 1])
title({'First Order Alternation','at Turn 1 by','Rotation Condition','on 4 Paths'})
xticklabels(table2array(summaryStats{1,2}(1:2:end,1)));

subplot(5,4,4)
bar(table2array(summaryStats{1,2}(1:2:end,10)))
ylim([0 1])
title({'Second Order Alternation','at Turn 1 by','Rotation Condition','on 4 Paths'})
xticklabels(table2array(summaryStats{1,2}(1:2:end,1)));

% Row 2 - Alternation at turn 1 on 8 paths
subplot(5,4,5)
bar(table2array(summaryStats{1,1}(2:2:end,4)))
ylim([0 1])
title({'First Order Alternation','at Turn 1 by','Recording Condition','on 8 Paths'})
xticklabels(table2array(summaryStats{1,1}(2:2:end,1)));

subplot(5,4,6)
bar(table2array(summaryStats{1,1}(2:2:end,10)))
ylim([0 1])
title({'Second Order Alternation','at Turn 1 by','Recording Condition','on 8 Paths'})
xticklabels(table2array(summaryStats{1,1}(2:2:end,1)));

subplot(5,4,7)
bar(table2array(summaryStats{1,2}(2:2:end,4)))
ylim([0 1])
title({'First Order Alternation','at Turn 1 by','Rotation Condition','on 8 Paths'})
xticklabels(table2array(summaryStats{1,2}(2:2:end,1)));

subplot(5,4,8)
bar(table2array(summaryStats{1,2}(2:2:end,10)))
ylim([0 1])
title({'Second Order Alternation','at Turn 1 by','Rotation Condition','on 8 Paths'})
xticklabels(table2array(summaryStats{1,2}(2:2:end,1)));

% Row 3 - Alternation at turn 2 on 8 paths
subplot(5,4,9)
bar(table2array(summaryStats{1,1}(2:2:end,6)))
ylim([0 1])
title({'First Order Alternation','at Turn 2 by','Recording Condition','on 8 Paths'})
xticklabels(table2array(summaryStats{1,1}(2:2:end,1)));

subplot(5,4,10)
bar(table2array(summaryStats{1,1}(2:2:end,12)))
ylim([0 1])
title({'Second Order Alternation','at Turn 2 by','Recording Condition','on 8 Paths'})
xticklabels(table2array(summaryStats{1,1}(2:2:end,1)));

subplot(5,4,11)
bar(table2array(summaryStats{1,2}(2:2:end,6)))
ylim([0 1])
title({'First Order Alternation','at Turn 2 by','Rotation Condition','on 8 Paths'})
xticklabels(table2array(summaryStats{1,2}(2:2:end,1)));

subplot(5,4,12)
bar(table2array(summaryStats{1,2}(2:2:end,12)))
ylim([0 1])
title({'Second Order Alternation','at Turn 2 by','Rotation Condition','on 8 Paths'})
xticklabels(table2array(summaryStats{1,2}(2:2:end,1)));


% Row 4 - Alteration by number of paths
subplot(5,4,13)
bar(table2array(summaryStats{1,3}(:,3)))
ylim([0 1])
title({'First Order Alternation','at Turn 1 by','Number of Paths'})
xticklabels(table2array(summaryStats{1,3}(:,1)));

subplot(5,4,14)
bar(table2array(summaryStats{1,3}(:,5)))
ylim([0 1])
title({'First Order Alternation','at Turn 2 by','Number of Paths'})
xticklabels(table2array(summaryStats{1,3}(:,1)));

subplot(5,4,15)
bar(table2array(summaryStats{1,3}(:,9)))
ylim([0 1])
title({'Second Order Alternation','at Turn 1 by','Number of Paths'})
xticklabels(table2array(summaryStats{1,3}(:,1)));

subplot(5,4,16)
bar(table2array(summaryStats{1,3}(:,11)))
ylim([0 1])
title({'Second Order Alternation','at Turn 2 by','Number of Paths'})
xticklabels(table2array(summaryStats{1,3}(:,1)));

% Row 5
subplot(5,4,17)
bar(table2array(summaryStats{1,4}((2:2:end),5)))
ylim([0 1])
title({'First Order Alternation','at Turn 1 by','Recording & Rotation','on 8 Paths'})
xticklabels(replace(string(summaryStats{1,4}.Properties.RowNames(2:2:end,1)),'_','-'));

subplot(5,4,18)
bar(table2array(summaryStats{1,4}((2:2:end),7)))
ylim([0 1])
title({'First Order Alternation','at Turn 2 by','Recording & Rotation','on 8 Paths'})
xticklabels(replace(string(summaryStats{1,4}.Properties.RowNames(2:2:end,1)),'_','-'));

subplot(5,4,19)
bar(table2array(summaryStats{1,4}((2:2:end),11)))
ylim([0 1])
title({'Second Order Alternation','at Turn 1 by','Recording & Rotation','on 8 Paths'})
xticklabels(replace(string(summaryStats{1,4}.Properties.RowNames(2:2:end,1)),'_','-'));

subplot(5,4,20)
bar(table2array(summaryStats{1,4}((2:2:end),13)))
ylim([0 1])
title({'Second Order Alternation','at Turn 2 by','Recording & Rotation','on 8 Paths'})
xticklabels(replace(string(summaryStats{1,4}.Properties.RowNames(2:2:end,1)),'_','-'));

%% Plot grouped bar plots
figure
set(gcf,'Position',[10 10 1200 1000])

% Row 1
subplot(4,4,1)
bar([table2array(summaryStats{1,1}(1:2:end,4)).';table2array(summaryStats{1,1}(2:2:end,4)).'])
ylim([0,1])
title({'First Order Alternation','at Turn 1 by','Recording Condition','on 4 vs 8 Paths'})
xticklabels({'4 Paths','8 Paths'})
lg1 = legend({'CTR','SAL','CNO'});
lg1.Location = 'northeastoutside';
% Error bars: need to pass bar position values to error bar positions
% hold on
% errorbar([table2array(summaryStats{1,1}(1:2:end,4)).';table2array(summaryStats{1,1}(2:2:end,4)).'],[table2array(summaryStats{1,1}(1:2:end,5)).';table2array(summaryStats{1,1}(2:2:end,5)).'])
% hold off

subplot(4,4,2)
bar([table2array(summaryStats{1,1}(1:2:end,10)).';table2array(summaryStats{1,1}(2:2:end,10)).'])
ylim([0,1])
title({'Second Order Alternation','at Turn 1 by','Recording Condition','on 4 vs 8 Paths'})
xticklabels({'4 Paths','8 Paths'})
lg2 = legend({'CTR','SAL','CNO'});
lg2.Location = 'northeastoutside';

subplot(4,4,3)
bar([table2array(summaryStats{1,2}(1:2:end,4)).';table2array(summaryStats{1,2}(2:2:end,4)).'])
ylim([0,1])
title({'First Order Alternation','at Turn 1 by','Rotation Condition','on 4 vs 8 Paths'})
xticklabels({'4 Paths','8 Paths'})
lg3 = legend({'NOR','ROT'});
lg3.Location = 'northeastoutside';

subplot(4,4,4)
bar([table2array(summaryStats{1,2}(1:2:end,10)).';table2array(summaryStats{1,2}(2:2:end,10)).'])
ylim([0,1])
title({'Second Order Alternation','at Turn 1 by','Rotation Condition','on 4 vs 8 Paths'})
xticklabels({'4 Paths','8 Paths'})
lg4 = legend({'NOR','ROT'});
lg4.Location = 'northeastoutside';

% Row 2
subplot(4,4,5)
bar([table2array(summaryStats{1,1}(2:2:end,4)).';table2array(summaryStats{1,1}(2:2:end,6)).'])
ylim([0,1])
title({'First Order Alternation','on 8 Paths by','Recording Condition','at Turns 1 vs 2'})
xticklabels({'Turn 1','Turn 2'})
lg5 = legend({'CTR','SAL','CNO'});
lg5.Location = 'northeastoutside';

subplot(4,4,6)
bar([table2array(summaryStats{1,1}(2:2:end,10)).';table2array(summaryStats{1,1}(2:2:end,12)).'])
ylim([0,1])
title({'Second Order Alternation','on 8 Paths by','Recording Condition','at Turns 1 vs 2'})
xticklabels({'Turn 1','Turn 2'})
lg6 = legend({'CTR','SAL','CNO'});
lg6.Location = 'northeastoutside';

subplot(4,4,7)
bar([table2array(summaryStats{1,2}(2:2:end,4)).';table2array(summaryStats{1,2}(2:2:end,6)).'])
ylim([0,1])
title({'First Order Alternation','on 8 Paths by','Rotation Condition','at Turns 1 vs 2'})
xticklabels({'Turn 1','Turn 2'})
lg7 = legend({'NOR','ROT'});
lg7.Location = 'northeastoutside';

subplot(4,4,8)
bar([table2array(summaryStats{1,2}(2:2:end,10)).';table2array(summaryStats{1,2}(2:2:end,12)).'])
ylim([0,1])
title({'Second Order Alternation','on 8 Paths by','Rotation Condition','at Turns 1 vs 2'})
xticklabels({'Turn 1','Turn 2'})
lg8 = legend({'NOR','ROT'});
lg8.Location = 'northeastoutside';