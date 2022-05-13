%% RSC Inactivation Exploratory Data Analysis - Data Processing & Figure
%{
This code is used to process data into figures
Charles Xu & Sagar Parikh 20220504
%}

%% Initialize
% Load CompiledDataTable

% Separate data by condition
CompiledDataTableCond_CTR = CompiledDataTable(CompiledDataTable{:,'Cond'} == "CTR",:);
CompiledDataTableCond_SAL = CompiledDataTable(CompiledDataTable{:,'Cond'} == "SAL",:);
CompiledDataTableCond_CNO = CompiledDataTable(CompiledDataTable{:,'Cond'} == "CNO",:);

% Separate data by rotation
CompiledDataTableRot_NOR = CompiledDataTable(CompiledDataTable{:,'Rot'} == "NOR",:);
CompiledDataTableRot_ROT = CompiledDataTable(CompiledDataTable{:,'Rot'} == "ROT",:);

%% Pull out block, error, and alternation indices

blkIndex = cell(size(CompiledDataTable, 1), 1);
errIndex = cell(size(CompiledDataTable, 1), 1);

for i = 1:size(CompiledDataTable, 1)
    currentRec_Blocks = CompiledDataTable.Blocks{i};
    currentRec_ErrorRoute = CompiledDataTable.ErrorRoute{i};
    currentRec_BlkIndex = ones(1, size(currentRec_Blocks, 2));
    for j = 2:size(currentRec_Blocks, 2)
        currentRec_BlkIndex(j) = length(currentRec_Blocks{j-1}) + currentRec_BlkIndex(j-1);
    end
    blkIndex{i,1} = currentRec_BlkIndex;
    
    
end

%% Distribution of error runs by condition
% Count the number of each error for each condition
% Data: 'ErrorRoute'



%% Distribution of runs
% Count the number of each run to determine biases

%% Mean errors
% Grouped barplot for mean errors by condition and rotation

%% Mean error per block
% Grouped barplot for mean errors per block by condition and rotation

%% Error block length vs PAlt
% Scatter plot

figure()
hold on

PFirstAltAt1 = zeros(size(CompiledDataTable, 1));
PSecondAltAt3 = zeros(size(CompiledDataTable, 1));
meanErrBlockLength = zeros(size(CompiledDataTable, 1));
for i = 1:size(CompiledDataTable, 1) % Loop across all recordings
    currentIsRT = CompiledDataTable.IsRInt{1};
    firstAlt = zeros(size(currentIsRT,1),size(currentIsRT,2)-1);
    secondAlt = zeros(size(currentIsRT,1),size(currentIsRT,2)-2);
    for j = 1:size(currentIsRT,1)
        for k = 2:size(currentIsRT,2)
            if xor(currentIsRT(j,k) == 1,currentIsRT(j,k-1) == 1)
                firstAlt(j,k-1) = 1;
            end
        end
    end
    for j = 1:size(firstAlt,1)
        for k = 2:size(firstAlt,2)
            if xor(firstAlt(j,k) == 1,firstAlt(j,k-1) == 1)
                secondAlt(j,k-1) = 1;
            end
        end
    end
    PFirstAltAt1(i) = sum(firstAlt(1,:))/size(firstAlt,2);
    PSecondAltAt3(i) = sum(secondAlt(3,:))/size(secondAlt,2);
    currentErrorBlock = CompiledDataTable.ErrorBlocks{1};
    meanErrBlockLength(i) = mean(currentErrorBlock);
end

scatter(PFirstAltAt1, meanErrBlockLength, 'red')
scatter(PSecondAltAt3, meanErrBlockLength, 'blue')
xlabel('Probability of alternation')
ylabel('Error block length')
legend('First degree alternation at turn 1', 'Second degree alternation at turn 2') % Fix later
hold off

%% Error rate vs PAlt
% Scatter plot; borrows PFirstAltAt1 and PSecondAltAt3 from previous
% section

figure()
hold on




%% Error block length over time
% Line plot of error block length over time for each condition

figure()

% For NOR
nCTR = 0;
for i = 1:size(CompiledDataTableRot_NOR, 1)
   if CompiledDataTableRot_NOR.Cond{i} == "CTR"
       nCTR = nCTR + 1;
   else
       break
   end
end

meanErrBlkLenCTR = nan(nCTR + 5);
meanErrBlkLenSAL = nan(nCTR + 5);
meanErrBlkLenCNO = nan(nCTR + 5);
[iCTR, iSAL, iCNO] = deal(1, nCTR + 1, nCTR + 1);

for i = 1:size(CompiledDataTableRot_NOR, 1)
   if CompiledDataTableRot_NOR.Cond{i} == "CTR"
       meanErrBlkLenCTR(iCTR) = mean(CompiledDataTableRot_NOR{i,'ErrorBlocks'}{1});
       iCTR = iCTR + 1;
   elseif CompiledDataTableRot_NOR.Cond{i} == "SAL"
       meanErrBlkLenSAL(iSAL) = mean(CompiledDataTableRot_NOR{i,'ErrorBlocks'}{1});
       iSAL = iSAL + 1;
   else
       meanErrBlkLenCNO(iCNO) = mean(CompiledDataTableRot_NOR{i,'ErrorBlocks'}{1});
       iCNO = iCNO + 1;
   end
end

subplot(211)
hold on
plot(meanErrBlkLenCTR, 'red')
plot(meanErrBlkLenSAL, 'blue')
plot(meanErrBlkLenCNO, 'green')
legend('Control', 'Saline', 'CNO')
hold off

% For ROT
nCTR = 0;
for i = 1:size(CompiledDataTableRot_ROT, 1)
   if CompiledDataTableRot_ROT.Cond{i} == "CTR"
       nCTR = nCTR + 1;
   else
       break
   end
end

meanErrBlkLenCTR = nan(nCTR + 5);
meanErrBlkLenSAL = nan(nCTR + 5);
meanErrBlkLenCNO = nan(nCTR + 5);
[iCTR, iSAL, iCNO] = deal(1, nCTR + 1, nCTR + 1);

for i = 1:size(CompiledDataTableRot_ROT, 1)
   if CompiledDataTableRot_ROT.Cond{i} == "CTR"
       meanErrBlkLenCTR(iCTR) = mean(CompiledDataTableRot_ROT{i,'ErrorBlocks'}{1});
       iCTR = iCTR + 1;
   elseif CompiledDataTableRot_ROT.Cond{i} == "SAL"
       meanErrBlkLenSAL(iSAL) = mean(CompiledDataTableRot_ROT{i,'ErrorBlocks'}{1});
       iSAL = iSAL + 1;
   else
       meanErrBlkLenCNO(iCNO) = mean(CompiledDataTableRot_ROT{i,'ErrorBlocks'}{1});
       iCNO = iCNO + 1;
   end
end

subplot(212)
hold on
plot(meanErrBlkLenCTR, 'red')
plot(meanErrBlkLenSAL, 'blue')
plot(meanErrBlkLenCNO, 'green')
legend('Control', 'Saline', 'CNO')
hold off

%% Mean error block length vs condition, broken down by rotation

figure()
hold on



%% Perfect percent vs condition, broken down by rotation

%% Mean error per block vs condition, broken down by rotation


%% One-way ANOVA by condition


