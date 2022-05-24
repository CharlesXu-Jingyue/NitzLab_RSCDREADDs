%% RSC Inactivation Exploratory Data Analysis
%{

%}

%% Load AthruI data for each rat

dataDir = '/Users/alveus/Documents/WorkingDirectory/LocalRepository/NitzLab_RSCDREADDs/DataAnalysis/WrappedData';
cd(dataDir)
ratList = ["SP10"]; % Change this to include all the rats to be analyzed
pathNum = 8; % Either 4 or 8
data = cell(1,length(ratList));

for n = 1:length(ratList)
    cd(strcat(ratList(n) + "/" + pathNum + "Paths"))
    load(dir("AThruI*").name)

    % Read into compiled data
    CompiledData = cell(filenum,28);

    for j = 1:filenum
        CompiledData{j,1} = num2cell(RecNum(j,1));
        CompiledData{j,2} = convertCharsToStrings(RecCondition(j,:));
        CompiledData{j,3} = convertCharsToStrings(RotationCondition(j,:));
        CompiledData{j,4} = Behavior.Runs{1,j};
        CompiledData{j,5} = Behavior.Blocks{1,j};
        CompiledData{j,6} = Performance.ErrorBlocks{1,j};
        CompiledData{j,7} = Performance.RewardBlocks{1,j};
        CompiledData{j,8} = Performance.ErrorRoute{1,j};
        CompiledData{j,9} = num2cell(Performance.MeanErrors(1,j));
        CompiledData{j,10} = num2cell(Performance.PerfectPercent(1,j));
        CompiledData{j,11} = Performance.PerfectBlocks{1,j};
        CompiledData{j,12} = Performance.PerfectBlockPermuationCounter{1,j};
        CompiledData{j,13} = BehaviorSeq.TransMatrix1{1,j};
        CompiledData{j,14} = BehaviorSeq.TransMatrix2{1,j};
        CompiledData{j,15} = BehaviorSeq.TransMatrixAll1{1,j};
        CompiledData{j,16} = BehaviorSeq.TransMatrixAll2{1,j};
        CompiledData{j,17} = TurnAnalysis.IsRightTurn_IntOnly{1,j};
        CompiledData{j,18} = num2cell(TurnAnalysis.PAlt_Turn1(1,j));
        CompiledData{j,19} = num2cell(TurnAnalysis.PAlt_Turn2Any(1,j));
        CompiledData{j,20} = num2cell(TurnAnalysis.PAlt_Turn3Any(1,j));
        CompiledData{j,21} = num2cell(TurnAnalysis.PAlt_Turn2Specific(1,j));
        CompiledData{j,22} = num2cell(TurnAnalysis.PAlt_Turn3Specific(1,j));
        CompiledData{j,23} = num2cell(TurnAnalysis.TotalRTurns(1,j));
        CompiledData{j,24} = num2cell(TurnAnalysis.TotalLTurns(1,j));
        CompiledData{j,25} = num2cell(Returns.PShortReturn(1,j));
        CompiledData{j,26} = num2cell(Returns.PLongReturn(1,j));
        CompiledData{j,27} = num2cell(Returns.PReturnSameSideNext(1,j));
        CompiledData{j,28} = num2cell(Returns.PReturnOppSideNext(1,j));
    end

    CompiledDataTable = cell2table(CompiledData, 'VariableNames', {'RecNum','Cond',...
        'Rot','Runs','Blocks','ErrorBlocks','RewardBlocks','ErrorRoute',...
        'MeanErrors','PerfectPercent','PerfectBlocks','PerfBlockPerm',...
        'TransMat1','TransMat2','TransMatAll1','TransMatAll2','IsRInt','PAlt1','PAlt2Any',...
        'PAlt3Any','PAlt2Spec','PAlt3Spec','TotRTurns','TotLTurns','PShortReturn','PLongReturn',...
        'PReturnSame','PReturnOppo'});
    
    data{1,n} = CompiledDataTable; % Store data of each rat into cell array "data"
    cd(dataDir)
end

clearvars -except data ratList

%% One-way ANOVA

mean(cell2mat(data{1,1}.PerfectPercent))

% Error rate

%% Two-way ANOVA

%% Kruskal-Wallis test

perfPercAll = []; % Setup empty array to contain data of some variable for all rats
for i = 1:length(ratList) % Loop over all rats
    currentRat = data{1,i}(:,["Cond","PerfectPercent"]); % Include condition and variable to analyze
    RatName = repmat(ratList(i), size(currentRat, 1), 1); % Setup rat name column
    currentRat = addvars(currentRat, RatName, 'Before', 'Cond'); % Combine them
    perfPercAll = [perfPercAll; currentRat]; % Concatenate to one array
end

p_kw = kruskalwallis(cell2mat(data{1,1}.PAlt1), CompiledDataTable.Cond);

%% K-S test

%% Mann-Witney test

%% Wilcox rank sum test

