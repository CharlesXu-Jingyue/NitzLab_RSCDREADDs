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
    load(dir("*AThruI*").name)

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

clearvars -except data ratList nRats pathNum


%% Set Up Variables for Analysis

perfPercAll = [];
MeanErrorsAll = [];
PAlt1All = [];
PAlt2AnyAll = [];
PAlt3AnyAll = [];
PAlt2SpecAll = [];
PAlt3SpecAll = [];
TotRTurnsAll = [];
TotLTurnsAll = [];
PShortRetAll = [];
PLongRetAll = [];
PSameRetAll = [];
POppRetAll = [];% Setup empty array to contain data of some variable for all rats
meanErrBlckLenAll = []; % Setup empty array to contain data of some variable for all rats
meanRewardBlckLenAll = [];
for i = 1:length(ratList) % Loop over all rats
    currentRat = data{1,i}(:,["Cond", "Rot"]);
    RatName = repmat(ratList(i), size(currentRat, 1), 1); % Setup rat name column 
    currentRat = addvars(currentRat, RatName, 'Before', 'Cond'); % Combine them
   
    
    currentMeanErrBlckLen = data{1,i}(:,"ErrorBlocks");
    currentMeanErrBlckLen.Properties.VariableNames(1) = {'MeanErrBlk'};
    for n = 1:length(currentMeanErrBlckLen.MeanErrBlk)
        currentMeanErrBlckLen.MeanErrBlk{n} = mean(currentMeanErrBlckLen.MeanErrBlk{n});
    end
    currentMeanErrBlckLen = [currentRat, currentMeanErrBlckLen]; %#ok<*AGROW>
    meanErrBlckLenAll = [meanErrBlckLenAll; currentMeanErrBlckLen];
    
    currentMeanRewardBlckLen = data{1,i}(:,"RewardBlocks");
    currentMeanRewardBlckLen.Properties.VariableNames(1) = {'MeanRewBlk'};
    for n = 1:length(currentMeanRewardBlckLen.MeanRewBlk)
        currentMeanRewardBlckLen.MeanRewBlk{n} = mean(currentMeanRewardBlckLen.MeanRewBlk{n});
    end
    currentMeanRewardBlckLen = [currentRat, currentMeanRewardBlckLen];
    meanRewardBlckLenAll = [meanRewardBlckLenAll; currentMeanRewardBlckLen];
    
    
    currentMeanErr = data{1,i}(:,"MeanErrors");
    currentMeanErr.Properties.VariableNames(1) = {'MeanErrors'};
    currentMeanErr = [currentRat, currentMeanErr];
    MeanErrorsAll = [MeanErrorsAll; currentMeanErr];
    
    currentPerfPerc = data{1,i}(:,"PerfectPercent");
    currentPerfPerc.Properties.VariableNames(1) = {'PerfectPercent'};
    currentPerfPerc = [currentRat, currentPerfPerc];
    perfPercAll = [perfPercAll; currentPerfPerc];
    
    currentPAlt1 = data{1,i}(:,"PAlt1");
    currentPAlt1.Properties.VariableNames(1) = {'PAlt1'};
    currentPAlt1 = [currentRat, currentPAlt1];
    PAlt1All = [PAlt1All; currentPAlt1];
    
    currentPAlt2Any = data{1,i}(:,"PAlt2Any");
    currentPAlt2Any.Properties.VariableNames(1) = {'PAlt2Any'};
    currentPAlt2Any = [currentRat, currentPAlt2Any];
    PAlt2AnyAll = [PAlt2AnyAll; currentPAlt2Any];
    
    currentPAlt3Any = data{1,i}(:,"PAlt3Any");
    currentPAlt3Any.Properties.VariableNames(1) = {'PAlt3Any'};
    currentPAlt3Any = [currentRat, currentPAlt3Any];
    PAlt3AnyAll = [PAlt3AnyAll; currentPAlt3Any];
    
    currentPAlt2Spec = data{1,i}(:,"PAlt2Spec");
    currentPAlt2Spec.Properties.VariableNames(1) = {'PAlt2Spec'};
    currentPAlt2Spec = [currentRat, currentPAlt2Spec];
    PAlt2SpecAll = [PAlt2SpecAll; currentPAlt2Spec];
    
    currentPAlt3Spec = data{1,i}(:,"PAlt3Spec");
    currentPAlt3Spec.Properties.VariableNames(1) = {'PAlt3Spec'};
    currentPAlt3Spec = [currentRat, currentPAlt3Spec];
    PAlt3SpecAll = [PAlt3SpecAll; currentPAlt3Spec];
    
    currentPShrtRtn = data{1,i}(:,"PShortReturn");
    currentPShrtRtn.Properties.VariableNames(1) = {'PShortReturn'};
    currentPShrtRtn = [currentRat, currentPShrtRtn];
    PShortRetAll = [PShortRetAll; currentPShrtRtn];
    
    currentPRtnOppo = data{1,i}(:,"PReturnOppo");
    currentPRtnOppo.Properties.VariableNames(1) = {'PReturnOppo'};
    currentPRtnOppo = [currentRat, currentPRtnOppo];
    POppRetAll = [POppRetAll; currentPRtnOppo];
    
    currentTotRTurns = data{1,i}(:,"TotRTurns");
    currentTotRTurns.Properties.VariableNames(1) = {'TotRTurns'};
    currentTotRTurns = [currentRat, currentTotRTurns];
    TotRTurnsAll = [TotRTurnsAll; currentTotRTurns];
    
    currentTotLTurns = data{1,i}(:,"TotLTurns");
    currentTotLTurns.Properties.VariableNames(1) = {'TotLTurns'};
    currentTotLTurns = [currentRat, currentTotLTurns];
    TotLTurnsAll = [TotLTurnsAll; currentTotLTurns];

end

clear current*

%% Kruskal-Wallis test


p_kwMeanErrors = kruskalwallis(cell2mat(MeanErrorsAll.MeanErrors), MeanErrorsAll.Cond);%4 vs 8 Paths Affects this
p_kwPerfPerc = kruskalwallis(cell2mat(perfPercAll.PerfectPercent), perfPercAll.Cond);
p_kwPAlt1 = kruskalwallis(cell2mat(PAlt1All.PAlt1), PAlt1All.Cond);
p_kwPAlt2Any = kruskalwallis(cell2mat(PAlt2AnyAll.PAlt2Any), PAlt2AnyAll.Cond);%4/8Affects this
p_kwPAlt3Any = kruskalwallis(cell2mat(PAlt3AnyAll.PAlt3Any), PAlt3AnyAll.Cond); 
p_kwPAlt2Spec = kruskalwallis(cell2mat(PAlt2SpecAll.PAlt2Spec), PAlt2SpecAll.Cond);
p_kwPAlt3Spec = kruskalwallis(cell2mat(PAlt3SpecAll.PAlt3Spec), PAlt3SpecAll.Cond);
p_kwTotRTurns = kruskalwallis(cell2mat(TotRTurnsAll.TotRTurns), TotRTurnsAll.Cond);
p_kwTotLTurns = kruskalwallis(cell2mat(TotLTurnsAll.TotLTurns), TotLTurnsAll.Cond);
p_kwPOppRet = kruskalwallis(cell2mat(POppRetAll.PReturnOppo), POppRetAll.Cond);
p_kwPSameRet = kruskalwallis(cell2mat(PSameRetAll.PReturnSame), PSameRetAll.Cond);
p_kwPShortRet = kruskalwallis(cell2mat(PShortRetAll.PShortReturn), PShortRetAll.Cond);%4/8 Paths Affects
p_kwPLongRet = kruskalwallis(cell2mat(PLongRetAll.PLongReturn), PLongRetAll.Cond); %4/8 Paths Affects
p_kwMeanErrBlkLen = kruskalwallis(cell2mat(meanErrBlckLenAll.MeanErrBlk), meanErrBlckLenAll.Cond);
p_kwMeanRewBlkLen = kruskalwallis(cell2mat(meanRewardBlckLenAll.MeanRewBlk), meanRewardBlckLenAll.Cond);

%% K-S test

 ks_MeanErrors = kstest2(cell2mat(MeanErrorsAll.MeanErrors(MeanErrorsAll.Cond == "CTR")),cell2mat(MeanErrorsAll.MeanErrors(MeanErrorsAll.Cond == "CNO")))
 ks_PerfPerc = kstest2(cell2mat(perfPercAll.PerfectPercent(perfPercAll.Cond == "CTR")),cell2mat(perfPercAll.PerfectPercent(perfPercAll.Cond == "CNO")))
 ks_PAlt1 = kstest2(cell2mat(PAlt1All.PAlt1(PAlt1All.Cond == "CTR")),cell2mat(PAlt1All.PAlt1(PAlt1All.Cond == "CNO")))
 ks_PAlt2Any = kstest2(cell2mat(PAlt2AnyAll.PAlt2Any(PAlt2AnyAll.Cond == "CTR")),cell2mat(PAlt2AnyAll.PAlt2Any(PAlt2AnyAll.Cond == "CNO")))
 ks_PAlt3Any = kstest2(cell2mat(PAlt3AnyAll.PAlt3Any(PAlt3AnyAll.Cond == "CTR")),cell2mat(PAlt3AnyAll.PAlt3Any(PAlt3AnyAll.Cond == "CNO")))
 ks_PAlt2Spec = kstest2(cell2mat(PAlt2SpecAll.PAlt2Spec(PAlt2SpecAll.Cond == "CTR")),cell2mat(PAlt2SpecAll.PAlt2Spec(PAlt2SpecAll.Cond == "CNO")))
 ks_PAlt3Spec = kstest2(cell2mat(PAlt3SpecAll.PAlt3Spec(PAlt3SpecAll.Cond == "CTR")),cell2mat(PAlt3SpecAll.PAlt3Spec(PAlt3SpecAll.Cond == "CNO")))
 ks_TotRTurns = kstest2(cell2mat(TotRTurnsAll.TotRTurns(TotRTurnsAll.Cond == "CTR")),cell2mat(TotRTurnsAll.TotRTurns(TotRTurnsAll.Cond == "CNO")))
 ks_TotLTurns = kstest2(cell2mat(TotLTurnsAll.TotLTurns(TotLTurnsAll.Cond == "CTR")),cell2mat(TotLTurnsAll.TotLTurns(TotLTurnsAll.Cond == "CNO")))
 ks_POppRet = kstest2(cell2mat(POppRetAll.PReturnOppo(POppRetAll.Cond == "CTR")),cell2mat(POppRetAll.PReturnOppo(POppRetAll.Cond == "CNO")))
 ks_PSameRet = kstest2(cell2mat(PSameRetAll.PReturnSame(PSameRetAll.Cond == "CTR")),cell2mat(PSameRetAll.PReturnSame(PSameRetAll.Cond == "CNO")))
 ks_PShortRet = kstest2(cell2mat(PShortRetAll.PShortReturn(PShortRetAll.Cond == "CTR")),cell2mat(PShortRetAll.PShortReturn(PShortRetAll.Cond == "CNO")))
 ks_MeanErrBlkLen = kstest2(cell2mat(meanErrBlckLenAll.MeanErrBlk(meanErrBlckLenAll.Cond == "CTR")),cell2mat(meanErrBlckLenAll.MeanErrBlk(meanErrBlckLenAll.Cond == "CNO")))
 ks_MeanRewBlkLen = kstest2(cell2mat(meanRewardBlckLenAll.MeanRewBlk(meanRewardBlckLenAll.Cond == "CTR")),cell2mat(meanRewardBlckLenAll.MeanRewBlk(meanRewardBlckLenAll.Cond == "CNO")))
 
%% Wilcox rank sum test/Mann-Whitney

cox_MeanErrors = ranksum(cell2mat(MeanErrorsAll.MeanErrors(MeanErrorsAll.Cond == "CTR")),cell2mat(MeanErrorsAll.MeanErrors(MeanErrorsAll.Cond == "CNO")))
cox_PerfPerc = ranksum(cell2mat(perfPercAll.PerfectPercent(perfPercAll.Cond == "CTR")),cell2mat(perfPercAll.PerfectPercent(perfPercAll.Cond == "CNO")))
cox_PAlt1 = ranksum(cell2mat(PAlt1All.PAlt1(PAlt1All.Cond == "CTR")),cell2mat(PAlt1All.PAlt1(PAlt1All.Cond == "CNO")))
cox_PAlt2Any = ranksum(cell2mat(PAlt2AnyAll.PAlt2Any(PAlt2AnyAll.Cond == "CTR")),cell2mat(PAlt2AnyAll.PAlt2Any(PAlt2AnyAll.Cond == "CNO")))
cox_PAlt3Any = ranksum(cell2mat(PAlt3AnyAll.PAlt3Any(PAlt3AnyAll.Cond == "CTR")),cell2mat(PAlt3AnyAll.PAlt3Any(PAlt3AnyAll.Cond == "CNO")))
cox_PAlt2Spec = ranksum(cell2mat(PAlt2SpecAll.PAlt2Spec(PAlt2SpecAll.Cond == "CTR")),cell2mat(PAlt2SpecAll.PAlt2Spec(PAlt2SpecAll.Cond == "CNO")))
cox_PAlt3Spec = ranksum(cell2mat(PAlt3SpecAll.PAlt3Spec(PAlt3SpecAll.Cond == "CTR")),cell2mat(PAlt3SpecAll.PAlt3Spec(PAlt3SpecAll.Cond == "CNO")))
cox_TotRTurns = ranksum(cell2mat(TotRTurnsAll.TotRTurns(TotRTurnsAll.Cond == "CTR")),cell2mat(TotRTurnsAll.TotRTurns(TotRTurnsAll.Cond == "CNO")))
cox_TotLTurns = ranksum(cell2mat(TotLTurnsAll.TotLTurns(TotLTurnsAll.Cond == "CTR")),cell2mat(TotLTurnsAll.TotLTurns(TotLTurnsAll.Cond == "CNO")))
cox_POppRet = ranksum(cell2mat(POppRetAll.PReturnOppo(POppRetAll.Cond == "CTR")),cell2mat(POppRetAll.PReturnOppo(POppRetAll.Cond == "CNO")))
cox_PSameRet = ranksum(cell2mat(PSameRetAll.PReturnSame(PSameRetAll.Cond == "CTR")),cell2mat(PSameRetAll.PReturnSame(PSameRetAll.Cond == "CNO")))
cox_PShortRet = ranksum(cell2mat(PShortRetAll.PShortReturn(PShortRetAll.Cond == "CTR")),cell2mat(PShortRetAll.PShortReturn(PShortRetAll.Cond == "CNO")))
cox_PLongRet = ranksum(cell2mat(PLongRetAll.PLongReturn(PLongRetAll.Cond == "CTR")),cell2mat(PLongRetAll.PLongReturn(PLongRetAll.Cond == "CNO")))
cox_MeanErrBlkLen = ranksum(cell2mat(meanErrBlckLenAll.MeanErrBlk(meanErrBlckLenAll.Cond == "CTR")),cell2mat(meanErrBlckLenAll.MeanErrBlk(meanErrBlckLenAll.Cond == "CNO")))
cox_MeanRewBlkLen = ranksum(cell2mat(meanRewardBlckLenAll.MeanRewBlk(meanRewardBlckLenAll.Cond == "CTR")),cell2mat(meanRewardBlckLenAll.MeanRewBlk(meanRewardBlckLenAll.Cond == "CNO")))
 
%% One Way Anova

[p_meanErrBlckLen, tbl_meanErrBlckLen, stats_meanErrBlckLen] = anova1(cell2mat(meanErrBlckLenAll.MeanErrBlk), meanErrBlckLenAll.Cond, 'off');
[p_meanRewardBlckLenAll, tbl_meanRewardBlckLenAll, stats_meanRewardBlckLenAll] = anova1(cell2mat(meanRewardBlckLenAll.MeanRewBlk), meanRewardBlckLenAll.Cond, 'off');
[p_meanErr, tbl_meanErr, stats_meanErr] = anova1(cell2mat(MeanErrorsAll.MeanErrors), MeanErrorsAll.Cond, 'off');
[p_perfPerc, tbl_perfPerc, stats_perfPerc] = anova1(cell2mat(perfPercAll.PerfectPercent), perfPercAll.Cond, 'off');
[p_pAlt1, tbl_pAlt1, stats_pAlt1] = anova1(cell2mat(PAlt1All.PAlt1), PAlt1All.Cond, 'off');
[p_pAlt2Any, tbl_pAlt2Any, stats_pAlt2Any] = anova1(cell2mat(PAlt2AnyAll.PAlt2Any), PAlt2AnyAll.Cond, 'off');
[p_pAlt3Any, tbl_pAlt3Any, stats_pAlt3Any] = anova1(cell2mat(PAlt3AnyAll.PAlt3Any), PAlt3AnyAll.Cond, 'off');
[p_pAlt2Spec, tbl_pAlt2Spec, stats_pAlt2Spec] = anova1(cell2mat(PAlt2SpecAll.PAlt2Spec), PAlt2SpecAll.Cond, 'off');
[p_pAlt3Spec, tbl_pAlt3Spec, stats_pAlt3Spec] = anova1(cell2mat(PAlt3SpecAll.PAlt3Spec), PAlt3SpecAll.Cond, 'off');
[p_pShrtRtn, tbl_pShrtRtn, stats_pShrtRtn] = anova1(cell2mat(PShortRetAll.PShortReturn), PShortRetAll.Cond, 'off');
[p_POppRet, tbl_POppRet, stats_POppRet] = anova1(cell2mat(POppRetAll.PReturnOppo), POppRetAll.Cond, 'off');


%% AnovaN/Two Way Anova

x_PShortRet = [cell2mat(PShortRetAll.PShortReturn)];
Cond_PShortRet = [cell2mat(PShortRetAll.Cond)];
Rot_PShortRet = [cell2mat(PShortRetAll.Rot)];

x_MeanErrBlk = [cell2mat(meanErrBlckLenAll.MeanErrBlk)];
Cond_MeanErrBlk = [cell2mat(meanErrBlckLenAll.Cond)];
Rot_MeanErrBlk = [cell2mat(meanErrBlckLenAll.Rot)];

x_MeanRewBlk = [cell2mat(meanRewardBlckLenAll.MeanRewBlk)];
Cond_MeanRewBlk = [cell2mat(meanRewardBlckLenAll.Cond)];
Rot_MeanRewBlk = [cell2mat(meanRewardBlckLenAll.Rot)];

x_MeanErrors = [cell2mat(MeanErrorsAll.MeanErrors)];
Cond_MeanErrors = [cell2mat(MeanErrorsAll.Cond)];
Rot_MeanErrors = [cell2mat(MeanErrorsAll.Rot)];

x_PerfPerc = [cell2mat(perfPercAll.PerfectPercent)];
Cond_PerfPerc = [cell2mat(perfPercAll.Cond)];
Rot_PerfPerc = [cell2mat(perfPercAll.Rot)];

x_PAlt1 = [cell2mat(PAlt1All.PAlt1)];
Cond_PAlt1 = [cell2mat(PAlt1All.Cond)];
Rot_PAlt1 = [cell2mat(PAlt1All.Rot)];

x_PAlt2Any = [cell2mat(PAlt2AnyAll.PAlt2Any)];
Cond_PAlt2Any = [cell2mat(PAlt2AnyAll.Cond)];
Rot_PAlt2Any = [cell2mat(PAlt2AnyAll.Rot)];

x_PAlt3Any = [cell2mat(PAlt3AnyAll.PAlt3Any)];
Cond_PAlt3Any = [cell2mat(PAlt3AnyAll.Cond)];
Rot_PAlt3Any = [cell2mat(PAlt3AnyAll.Rot)];

x_PAlt2Spec = [cell2mat(PAlt2SpecAll.PAlt2Spec)];
Cond_PAlt2Spec = [cell2mat(PAlt2SpecAll.Cond)];
Rot_PAlt2Spec = [cell2mat(PAlt2SpecAll.Rot)];

x_PAlt3Spec = [cell2mat(PAlt3SpecAll.PAlt3Spec)];
Cond_PAlt3Spec = [cell2mat(PAlt3SpecAll.Cond)];
Rot_PAlt3Spec = [cell2mat(PAlt3SpecAll.Rot)];

x_POppReturn = [cell2mat(POppRetAll.PReturnOppo)];
Cond_POppReturn = [cell2mat(POppRetAll.Cond)];
Rot_POppReturn = [cell2mat(POppRetAll.Rot)];


[p_NPShrtRtn, table_NPShrtRtn, stats_NPShrtRtn] = anovan(x_PShortRet,{Cond_PShortRet, Rot_PShortRet},'model',2,'varnames',{'Cond', 'Rot'})
[p_NMeanErrBlk, table_NMeanErBlk, stats_NMeanErrBlk] = anovan(x_MeanErrBlk,{Cond_MeanErrBlk, Rot_MeanErrBlk},'model',2,'varnames',{'Cond', 'Rot'})
[p_NMeanRewBlk, table_NMeanRewBlk, stats_NMeanRewBlk] = anovan(x_MeanRewBlk,{Cond_MeanRewBlk, Rot_MeanRewBlk},'model',2,'varnames',{'Cond', 'Rot'})
[p_NMeanErrors, table_NMeanErrors, stats_NMeanErrors] = anovan(x_MeanErrors,{Cond_MeanErrors, Rot_MeanErrors},'model',2,'varnames',{'Cond', 'Rot'})
[p_NPerfPerc, table_NPerfPerc, stats_NPerfPerc] = anovan(x_PerfPerc,{Cond_PerfPerc, Rot_PerfPerc},'model',2,'varnames',{'Cond', 'Rot'})
[p_NPAlt1, table_NPAlt1, stats_NPAlt1] = anovan(x_PAlt1,{Cond_PAlt1, Rot_PAlt1},'model',2,'varnames',{'Cond', 'Rot'})
[p_NPAlt2Any, table_NPAlt2Any, stats_NPAlt2Any] = anovan(x_PAlt2Any,{Cond_PAlt2Any, Rot_PAlt2Any},'model',2,'varnames',{'Cond', 'Rot'})
[p_NPAlt3Any, table_NPAlt3Any, stats_NPAlt3Any] = anovan(x_PAlt3Any,{Cond_PAlt3Any, Rot_PAlt3Any},'model',2,'varnames',{'Cond', 'Rot'})
[p_NPAlt2Spec, table_NPAlt2Spec, stats_NPAlt2Spec] = anovan(x_PAlt2Spec,{Cond_PAlt2Spec, Rot_PAlt2Spec},'model',2,'varnames',{'Cond', 'Rot'})
[p_NPAlt3Spec, table_NPAlt3Spec, stats_NPAlt3Spec] = anovan(x_PAlt3Spec,{Cond_PAlt3Spec, Rot_PAlt3Spec},'model',2,'varnames',{'Cond', 'Rot'})
[p_NPOppReturn, table_NPOppReturn, stats_NPOppReturn] = anovan(x_POppReturn,{Cond_POppReturn, Rot_POppReturn},'model',2,'varnames',{'Cond', 'Rot'})





%% #s from First 3 CNO, SAL, and CTR data

