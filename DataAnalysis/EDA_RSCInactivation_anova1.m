%% RSC Inactivation Exploratory Data Analysis
%{

%}

%% Load AthruI data for each rat

dataDir = '/Users/alveus/Documents/WorkingDirectory/LocalRepository/NitzLab_RSCDREADDs/DataAnalysis/WrappedData';
cd(dataDir)
ratList = ["SP9", "SP10"]; % Change this to include all the rats to be analyzed
nRats = length(ratList);
pathNum = 4; % Either 4 or 8
data = cell(1,length(ratList));

for n = 1:nRats
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

clearvars -except ratList nRats pathNum data

%% One-way ANOVA

meanErrBlckLenAll = []; % Setup empty array to contain data of some variable for all rats
meanRewardBlckLenAll = [];
meanErrAll = [];
perfPercAll = [];
pAlt1All = [];
pAlt2AnyAll = [];
pAlt3AnyAll = [];
pAlt2SpecAll = [];
pAlt3SpecAll = [];
pShrtRtnAll = [];
pRtnOppoAll = [];

for n = 1:nRats
    currentRat = data{1,n}(:,"Cond");
    RatName = repmat(ratList(n), size(currentRat, 1), 1); % Setup rat name column
    currentRat = addvars(currentRat, RatName, 'Before', 'Cond'); % Combine them
    
    currentMeanErrBlckLen = data{1,n}(:,"ErrorBlocks");
    currentMeanErrBlckLen.Properties.VariableNames(1) = {'Data'};
    for i = 1:length(currentMeanErrBlckLen.Data)
        currentMeanErrBlckLen.Data{i} = mean(currentMeanErrBlckLen.Data{i});
    end
    currentMeanErrBlckLen = [currentRat, currentMeanErrBlckLen]; %#ok<*AGROW>
    meanErrBlckLenAll = [meanErrBlckLenAll; currentMeanErrBlckLen];
    
    currentMeanRewardBlckLen = data{1,n}(:,"RewardBlocks");
    currentMeanRewardBlckLen.Properties.VariableNames(1) = {'Data'};
    for i = 1:length(currentMeanRewardBlckLen.Data)
        currentMeanRewardBlckLen.Data{i} = mean(currentMeanRewardBlckLen.Data{i});
    end
    currentMeanRewardBlckLen = [currentRat, currentMeanRewardBlckLen];
    meanRewardBlckLenAll = [meanRewardBlckLenAll; currentMeanRewardBlckLen];
    
    currentMeanErr = data{1,n}(:,"MeanErrors");
    currentMeanErr.Properties.VariableNames(1) = {'Data'};
    currentMeanErr = [currentRat, currentMeanErr];
    meanErrAll = [meanErrAll; currentMeanErr];
    
    currentPerfPerc = data{1,n}(:,"PerfectPercent");
    currentPerfPerc.Properties.VariableNames(1) = {'Data'};
    currentPerfPerc = [currentRat, currentPerfPerc];
    perfPercAll = [perfPercAll; currentPerfPerc];
    
    currentPAlt1 = data{1,n}(:,"PAlt1");
    currentPAlt1.Properties.VariableNames(1) = {'Data'};
    currentPAlt1 = [currentRat, currentPAlt1];
    pAlt1All = [pAlt1All; currentPAlt1];
    
    currentPAlt2Any = data{1,n}(:,"PAlt2Any");
    currentPAlt2Any.Properties.VariableNames(1) = {'Data'};
    currentPAlt2Any = [currentRat, currentPAlt2Any];
    pAlt2AnyAll = [pAlt2AnyAll; currentPAlt2Any];
    
    currentPAlt3Any = data{1,n}(:,"PAlt3Any");
    currentPAlt3Any.Properties.VariableNames(1) = {'Data'};
    currentPAlt3Any = [currentRat, currentPAlt3Any];
    pAlt3AnyAll = [pAlt3AnyAll; currentPAlt3Any];
    
    currentPAlt2Spec = data{1,n}(:,"PAlt2Spec");
    currentPAlt2Spec.Properties.VariableNames(1) = {'Data'};
    currentPAlt2Spec = [currentRat, currentPAlt2Spec];
    pAlt2SpecAll = [pAlt2SpecAll; currentPAlt2Spec];
    
    currentPAlt3Spec = data{1,n}(:,"PAlt3Spec");
    currentPAlt3Spec.Properties.VariableNames(1) = {'Data'};
    currentPAlt3Spec = [currentRat, currentPAlt3Spec];
    pAlt3SpecAll = [pAlt3SpecAll; currentPAlt3Spec];
    
    currentPShrtRtn = data{1,n}(:,"PShortReturn");
    currentPShrtRtn.Properties.VariableNames(1) = {'Data'};
    currentPShrtRtn = [currentRat, currentPShrtRtn];
    pShrtRtnAll = [pShrtRtnAll; currentPShrtRtn];
    
    currentPRtnOppo = data{1,n}(:,"PReturnOppo");
    currentPRtnOppo.Properties.VariableNames(1) = {'Data'};
    currentPRtnOppo = [currentRat, currentPRtnOppo];
    pRtnOppoAll = [pRtnOppoAll; currentPRtnOppo];
end

clear current*

[p_meanErrBlckLen, tbl_meanErrBlckLen, stats_meanErrBlckLen] = anova1(cell2mat(meanErrBlckLenAll.Data), meanErrBlckLenAll.Cond, 'off');
[p_meanRewardBlckLenAll, tbl_meanRewardBlckLenAll, stats_meanRewardBlckLenAll] = anova1(cell2mat(meanRewardBlckLenAll.Data), meanRewardBlckLenAll.Cond, 'off');
[p_meanErr, tbl_meanErr, stats_meanErr] = anova1(cell2mat(meanErrAll.Data), meanErrAll.Cond, 'off');
[p_perfPerc, tbl_perfPerc, stats_perfPerc] = anova1(cell2mat(perfPercAll.Data), perfPercAll.Cond, 'off');
[p_pAlt1, tbl_pAlt1, stats_pAlt1] = anova1(cell2mat(pAlt1All.Data), pAlt1All.Cond, 'off');
[p_pAlt2Any, tbl_pAlt2Any, stats_pAlt2Any] = anova1(cell2mat(pAlt2AnyAll.Data), pAlt2AnyAll.Cond, 'off');
[p_pAlt3Any, tbl_pAlt3Any, stats_pAlt3Any] = anova1(cell2mat(pAlt3AnyAll.Data), pAlt3AnyAll.Cond, 'off');
[p_pAlt2Spec, tbl_pAlt2Spec, stats_pAlt2Spec] = anova1(cell2mat(pAlt2SpecAll.Data), pAlt2SpecAll.Cond, 'off');
[p_pAlt3Spec, tbl_pAlt3Spec, stats_pAlt3Spec] = anova1(cell2mat(pAlt3SpecAll.Data), pAlt3SpecAll.Cond, 'off');
[p_pShrtRtn, tbl_pShrtRtn, stats_pShrtRtn] = anova1(cell2mat(pShrtRtnAll.Data), pShrtRtnAll.Cond, 'off');
[p_pRtnOppo, tbl_pRtnOppo, stats_pRtnOppo] = anova1(cell2mat(pRtnOppoAll.Data), pRtnOppoAll.Cond, 'off');

%% Two-way ANOVA

%% Kruskal-Wallis test

p_kw = kruskalwallis(cell2mat(data{1,1}.PAlt1), CompiledDataTable.Cond);

%% K-S test

%% Mann-Witney test

%% Wilcox rank sum test

meanErrAll.Data(meanErrAll.Cond == "CTR");
