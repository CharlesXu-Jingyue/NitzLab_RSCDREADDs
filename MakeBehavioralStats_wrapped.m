function [A_Runtimes, ...
    A_Timestamps,...
    A_Velocity,...
    A_HD,...
    B_All,...
    B_Runs,...
    B_Blocks,...
    C_ErrorBlocks,...
    C_RewardBlocks,...
    C_ErrorRoute,...
    C_MeanErrors,...
    C_PerfectPercent,...
    D_Runticker_All,...
    D_Runticker_Internals,...
    E_Route1Prob,...
    F_TransMatrix1,...
    F_TransMatrix2,...
    F_TransMatrixAll1,...
    F_TransMatrixAll2,...
    G_IsRightTurn_IntOnly,...
    G_PAlt_Turn1,...
    G_PAlt_Turn2Any,...
    G_PAlt_Turn3Any,...
    G_PAlt_Turn2Specific,...
    G_PAlt_Turn3Specific,...
    G_TotalRTurns,...
    G_TotalLTurns,...
    H_PShortReturn,...
    H_PLongReturn,...
    H_PReturnSameSideNext,...
    H_PReturnOppSideNext,...
    I_PerfBlocks,...
    I_PermCounter] = MakeBehavioralStats_wrapped(NumRoutes,indRecStruct)

%% Called function to analyze all behavioral data on TripleT maze for CNO pilot study

% Alex Johnson Winter 2021/2022
%
% INPUTS
% NumRoutes = Number of internal routes ran
% indRecStruct = post behavioral scoring struct of recording on TTT
% 
% OUTPUTS
%
%
% Called fxns
%
%
%


%% Make starts and stops to pull out behavior data 

A_Timestamps = indRecStruct.processedDVT(:,2);

A_RunNum = 1; %For starts
for iEvent = 1:length(indRecStruct.events)
    if abs(indRecStruct.events(iEvent,3))>=1 && (abs(indRecStruct.events(iEvent,3))<50)
        A_Starts(A_RunNum,1) = indRecStruct.events(iEvent,1);
        A_Starts(A_RunNum,2) = indRecStruct.events(iEvent,2);
        A_Starts(A_RunNum,3) = abs(indRecStruct.events(iEvent,3));
        A_RunNum = A_RunNum+1;
    end
end

A_RunNum = 1; %For Ends 
for iEvent = 1:length(indRecStruct.events)
    if abs(indRecStruct.events(iEvent,3))>=100 && (abs(indRecStruct.events(iEvent,3))<150)
        A_Ends(A_RunNum,1) = indRecStruct.events(iEvent,1);
        A_Ends(A_RunNum,2) = indRecStruct.events(iEvent,2);
        A_Ends(A_RunNum,3) = abs(indRecStruct.events(iEvent,3));
        A_RunNum = A_RunNum+1;
    end
end
A_Starts = sortrows(A_Starts,2);
A_Ends = sortrows(A_Ends,2);

for jStart = 1:length(A_Starts)
        pRun = A_Timestamps(:)>=A_Starts(jStart,2)&A_Timestamps<=A_Ends(jStart,2);
        A_Runtimes{jStart,1} = A_Timestamps(pRun);
end

for kStart = 1:length(A_Starts(:,3))
    A_Runtimes{kStart,2}=A_Starts(kStart,3);
end

A_Velocity = indRecStruct.velSmoothed;
A_HD = indRecStruct.HDRadians;

clear jStart pRun iEvent A_RunNum kStart

%% Create blocks of trials

jInternals = find(A_Starts(:,3)>=1&A_Starts(:,3)<=NumRoutes);
kExternals = find(A_Starts(:,3)>=9&A_Starts(:,3)<=10);
lAll = find(A_Starts(:,3)>=1&A_Starts(:,3)<=10);
B_Runs(:,1) = A_Starts(jInternals,3);
B_Returns(:,1) = A_Starts(kExternals,3);
B_All(:,1) =A_Starts(lAll,3);

clear jInternals kExternals lAll

B_PositionInBlock = [];
jBlock = 1;
pRunInBlock = 1;
kBlockCounter = zeros(NumRoutes,1);

for iBlock=1:length(B_Runs)
    B_Blocks{jBlock}(1,pRunInBlock) = B_Runs(iBlock);
    pRunInBlock=pRunInBlock+1;
    if B_Runs(iBlock) == 1
            if kBlockCounter(1,1)==0
                B_PositionInBlock(iBlock) = sum(kBlockCounter)+1;
            end
            if kBlockCounter(1,1)==1
                B_PositionInBlock(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
            end
        kBlockCounter(1,1) = 1;
    end
    if B_Runs(iBlock) == 2
            if kBlockCounter(2,1)==0
                B_PositionInBlock(iBlock) = sum(kBlockCounter)+1;
            end
            if kBlockCounter(2,1)==1
                B_PositionInBlock(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
            end
        kBlockCounter(2,1) = 1;
    end
    if B_Runs(iBlock) == 3
            if kBlockCounter(3,1)==0
                B_PositionInBlock(iBlock) = sum(kBlockCounter)+1;
            end
            if kBlockCounter(3,1)==1
                B_PositionInBlock(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
            end
        kBlockCounter(3,1) = 1;
    end
    if B_Runs(iBlock) == 4
            if kBlockCounter(4,1)==0
                B_PositionInBlock(iBlock) = sum(kBlockCounter)+1;
            end
            if kBlockCounter(4,1)==1
                B_PositionInBlock(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
            end
        kBlockCounter(4,1) = 1;
    end
    if B_Runs(iBlock) == 5
            if kBlockCounter(5,1)==0
                B_PositionInBlock(iBlock) = sum(kBlockCounter)+1;
            end
            if kBlockCounter(5,1)==1
                B_PositionInBlock(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
            end
        kBlockCounter(5,1) = 1;
    end
    if B_Runs(iBlock) == 6
            if kBlockCounter(6,1)==0
               B_PositionInBlock(iBlock) = sum(kBlockCounter)+1;
            end
            if kBlockCounter(6,1)==1
               B_PositionInBlock(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
            end
        kBlockCounter(6,1) = 1;
    end
    if B_Runs(iBlock) == 7
            if kBlockCounter(7,1)==0
                B_PositionInBlock(iBlock) = sum(kBlockCounter)+1;
            end
            if kBlockCounter(7,1)==1
                B_PositionInBlock(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
            end
        kBlockCounter(7,1) = 1;
    end
    if B_Runs(iBlock) == 8
            if kBlockCounter(8,1)==0
                 B_PositionInBlock(iBlock) = sum(kBlockCounter)+1;
            end
            if kBlockCounter(8,1)==1
                 B_PositionInBlock(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
            end
        kBlockCounter(8,1) = 1;
    end
    if sum(kBlockCounter) == length(kBlockCounter) 
        jBlock = jBlock+1;
        pRunInBlock=1;
        kBlockCounter = zeros(NumRoutes,1);
    end
end
clear iBlock jBlock kBlockCounter pRunInBlock

% Make version counting returns as same value as previous run position

B_PositionInBlockAll = [];
jBlock = 1;
pRunInBlock = 1;
kBlockCounter = zeros(NumRoutes,1);

for iBlock=1:length(B_All)
    if ismember(B_All(iBlock), [1:NumRoutes]) 
        B_Blocks{jBlock}(1,pRunInBlock) = B_All(iBlock);
        pRunInBlock=pRunInBlock+1;
        if B_All(iBlock) == 1
                if kBlockCounter(1,1)==0
                    B_PositionInBlockAll(iBlock) = sum(kBlockCounter)+1;
                end
                if kBlockCounter(1,1)==1
                    B_PositionInBlockAll(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
                end
            kBlockCounter(1,1) = 1;
        end
        if B_All(iBlock) == 2
                if kBlockCounter(2,1)==0
                    B_PositionInBlockAll(iBlock) = sum(kBlockCounter)+1;
                end
                if kBlockCounter(2,1)==1
                    B_PositionInBlockAll(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
                end
            kBlockCounter(2,1) = 1;
        end
        if B_All(iBlock) == 3
                if kBlockCounter(3,1)==0
                    B_PositionInBlockAll(iBlock) = sum(kBlockCounter)+1;
                end
                if kBlockCounter(3,1)==1
                    B_PositionInBlockAll(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
                end
            kBlockCounter(3,1) = 1;
        end
        if B_All(iBlock) == 4
                if kBlockCounter(4,1)==0
                    B_PositionInBlockAll(iBlock) = sum(kBlockCounter)+1;
                end
                if kBlockCounter(4,1)==1
                    B_PositionInBlockAll(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
                end
            kBlockCounter(4,1) = 1;
        end
        if B_All(iBlock) == 5
                if kBlockCounter(5,1)==0
                    B_PositionInBlockAll(iBlock) = sum(kBlockCounter)+1;
                end
                if kBlockCounter(5,1)==1
                    B_PositionInBlockAll(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
                end
            kBlockCounter(5,1) = 1;
        end
        if B_All(iBlock) == 6
                if kBlockCounter(6,1)==0
                   B_PositionInBlockAll(iBlock) = sum(kBlockCounter)+1;
                end
                if kBlockCounter(6,1)==1
                   B_PositionInBlockAll(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
                end
            kBlockCounter(6,1) = 1;
        end
        if B_All(iBlock) == 7
                if kBlockCounter(7,1)==0
                    B_PositionInBlockAll(iBlock) = sum(kBlockCounter)+1;
                end
                if kBlockCounter(7,1)==1
                    B_PositionInBlockAll(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
                end
            kBlockCounter(7,1) = 1;
        end
        if B_All(iBlock) == 8
                if kBlockCounter(8,1)==0
                     B_PositionInBlockAll(iBlock) = sum(kBlockCounter)+1;
                end
                if kBlockCounter(8,1)==1
                     B_PositionInBlockAll(iBlock) = (sum(kBlockCounter)-length(kBlockCounter)) ;
                end
            kBlockCounter(8,1) = 1;
        end
    end

        if B_All(iBlock) == 9
            B_PositionInBlockAll(iBlock) = (sum(kBlockCounter));
        end
        if B_All(iBlock) == 10
            B_PositionInBlockAll(iBlock) = (sum(kBlockCounter));
        end
    
        if sum(kBlockCounter) == length(kBlockCounter) 
            jBlock = jBlock+1;
            pRunInBlock=1;
            kBlockCounter = zeros(NumRoutes,1);
        end
end

B_PositionInBlockAll(find(B_PositionInBlockAll==0))=8;

clear iBlock jBlock kBlockCounter pRunInBlock


%% Find errors/not do error analysis

C_AllErrors = zeros(size(B_PositionInBlockAll));
C_RunsErrors = zeros(size(B_PositionInBlock));
C_AllErrors(B_PositionInBlockAll<0)=1;
C_RunsErrors(B_PositionInBlock<0)=1;

for iBlock=1:length(B_Blocks)
    C_NumRuns(iBlock) = numel(B_Blocks{iBlock});
        if numel(B_Blocks{iBlock}) < NumRoutes
            B_Blocks(iBlock) = [];
        end
     C_NumErrors(iBlock) =(C_NumRuns(iBlock))-NumRoutes;
        if C_NumErrors(iBlock)<0
            C_NumErrors(iBlock) = 0;
        end
end

spot = 1;
for iBlock = 1:length(B_PositionInBlock)
    if B_PositionInBlock(iBlock) < 0
        C_ErrorRoute(spot) = B_Runs(iBlock);
        spot = spot+1;
    end
end

C_PerfectPercent = (length(find(C_NumErrors==0))/(length(B_Blocks)));
C_MeanErrors = ((sum(C_NumErrors))/(length(B_Blocks)));

clear spot iBlock

% Make error and reward bout lengths

C_ErrorBlocks =[];
C_RewardBlocks =[];

GoodBadDecider = 0;
ErrorSize = 0;
RewSize = 0;
ErrorBoutNum = 1;
RewBoutNum = 1;

 for kRun = 1:length(C_RunsErrors)-1
     GoodBadDecider = C_RunsErrors(kRun);

      if GoodBadDecider == 1
            ErrorSize = ErrorSize+1;
                 if GoodBadDecider == 1 && C_RunsErrors(kRun+1) == 0
                      C_ErrorBlocks(ErrorBoutNum) = ErrorSize;
                      ErrorSize = 0;
                      ErrorBoutNum = ErrorBoutNum+1;
                 end
          
      end
      if GoodBadDecider == 0
            RewSize = RewSize+1;
                 if GoodBadDecider == 0 && C_RunsErrors(kRun+1) == 1
                      C_RewardBlocks(RewBoutNum) = RewSize;
                      RewSize = 0;
                      RewBoutNum = RewBoutNum+1;
                 end
          
      end
 end

 clear GoodBadDecider ErrorSize ErrorBoutNum kRun RewBoutNum RewSize

%% Create RunTickers 
D_Runticker_Internals = zeros(length(B_Runs),length(unique(B_Runs)));
D_Runticker_All = zeros(length(B_All),length(unique(B_Runs))+2);

% Without Returns
for iRun = 1:length(B_Runs)
    D_Runticker_Internals(iRun,(B_Runs(iRun)))= (B_PositionInBlock(iRun));
end

% With Returns 
for iRun = 1:length(B_All)
    D_Runticker_All(iRun,(B_All(iRun)))= (B_PositionInBlockAll(iRun));
end

clear iRun

%% Create route-route probabilities 
E_O1ROUTES = [1:NumRoutes];
E_O2ROUTES = combvec(E_O1ROUTES,E_O1ROUTES);
E_O3ROUTES = combvec(E_O1ROUTES,E_O1ROUTES,E_O1ROUTES);
E_O4ROUTES = combvec(E_O1ROUTES,E_O1ROUTES,E_O1ROUTES,E_O1ROUTES);

%Probability of each route, calculated separately for internal/external 

% internals
for jRunCheck = 1:length(B_Runs)
    TempChunkO1(:,jRunCheck) = [B_Runs(jRunCheck)];
end
for jRunCheck = 1:length(B_Runs)-1
    TempChunkO2(:,jRunCheck) = [B_Runs(jRunCheck),B_Runs(jRunCheck+1)];
end
for jRunCheck = 1:length(B_Runs)-2
    TempChunkO3(:,jRunCheck) = [B_Runs(jRunCheck),B_Runs(jRunCheck+1),B_Runs(jRunCheck+2)];
end
for jRunCheck = 1:length(B_Runs)-3
    TempChunkO4(:,jRunCheck) = [B_Runs(jRunCheck),B_Runs(jRunCheck+1),B_Runs(jRunCheck+2),B_Runs(jRunCheck+3)];
end

for kPerm = 1:size(E_O1ROUTES,2)
    PermTest = E_O1ROUTES(:,kPerm);
    PermSums(kPerm) = sum(ismember(TempChunkO1',PermTest','rows'));
end
    E_Route1Prob = PermSums/(sum(PermSums)); %First Order done

    clear PermSums PermTest

for kPerm = 1:size(E_O2ROUTES,2)
    PermTest = E_O2ROUTES(:,kPerm);
    PermSums(kPerm) = sum(ismember(TempChunkO2',PermTest','rows'));
end
    E_Route2Prob = PermSums/(sum(PermSums)); %First Order done

    clear PermSums PermTest

for kPerm = 1:size(E_O3ROUTES,2)
    PermTest = E_O3ROUTES(:,kPerm);
    PermSums(kPerm) = sum(ismember(TempChunkO3',PermTest','rows'));
end
    E_Route3Prob = PermSums/(sum(PermSums)); %First Order done

    clear PermSums PermTest

for kPerm = 1:size(E_O4ROUTES,2)
    PermTest = E_O4ROUTES(:,kPerm);
    PermSums(kPerm) = sum(ismember(TempChunkO4',PermTest','rows'));
end
    E_Route4Prob = PermSums/(sum(PermSums)); %First Order done

    clear PermSums PermTest


clear PermProb PermSums PermTest kPerm jRunCheck iRouteNum  ROUTES

% All Routes

E_O1AllROUTES = [1:NumRoutes,9,10];
E_O2AllROUTES = combvec(E_O1AllROUTES,E_O1AllROUTES);
E_O3AllROUTES = combvec(E_O1AllROUTES,E_O1AllROUTES,E_O1AllROUTES);
E_O4AllROUTES = combvec(E_O1AllROUTES,E_O1AllROUTES,E_O1AllROUTES,E_O1AllROUTES);

%Probability of each route, calculated separately for internal/external 

% internals
for jRunCheck = 1:length(B_All)
    TempChunkAllO1(:,jRunCheck) = [B_All(jRunCheck)];
end
for jRunCheck = 1:length(B_All)-1
    TempChunkAllO2(:,jRunCheck) = [B_All(jRunCheck),B_All(jRunCheck+1)];
end
for jRunCheck = 1:length(B_All)-2
    TempChunkAllO3(:,jRunCheck) = [B_All(jRunCheck),B_All(jRunCheck+1),B_All(jRunCheck+2)];
end
for jRunCheck = 1:length(B_All)-3
    TempChunkAllO4(:,jRunCheck) = [B_All(jRunCheck),B_All(jRunCheck+1),B_All(jRunCheck+2),B_All(jRunCheck+3)];
end

for kPerm = 1:size(E_O1AllROUTES,2)
    PermTest = E_O1AllROUTES(:,kPerm);
    PermSums(kPerm) = sum(ismember(TempChunkAllO1',PermTest','rows'));
end
    E_Route1AllProb = PermSums/(sum(PermSums)); %First Order done

    clear PermSums PermTest

for kPerm = 1:size(E_O2ROUTES,2)
    PermTest = E_O2ROUTES(:,kPerm);
    PermSums(kPerm) = sum(ismember(TempChunkAllO2',PermTest','rows'));
end
    E_Route2AllProb = PermSums/(sum(PermSums)); %First Order done

    clear PermSums PermTest

for kPerm = 1:size(E_O3ROUTES,2)
    PermTest = E_O3ROUTES(:,kPerm);
    PermSums(kPerm) = sum(ismember(TempChunkAllO3',PermTest','rows'));
end
    E_Route3AllProb = PermSums/(sum(PermSums)); %First Order done

    clear PermSums PermTest

for kPerm = 1:size(E_O4ROUTES,2)
    PermTest = E_O4ROUTES(:,kPerm);
    PermSums(kPerm) = sum(ismember(TempChunkAllO4',PermTest','rows'));
end
    E_Route4AllProb = PermSums/(sum(PermSums)); %First Order done

    clear PermSums PermTest


clear PermProb PermSums PermTest kPerm jRunCheck iRouteNum 

%% Create Transition Matrices

% Without returns

SumMatrix1 = zeros(length(E_O1ROUTES),length(E_O1ROUTES));
F_TransMatrix1 = zeros(length(E_O1ROUTES),length(E_O1ROUTES));
OrderTransitions = length(TempChunkO1)-1; %needed to normalize
    for iRun = 1:OrderTransitions
        ComboIndex = find(ismember(E_O1ROUTES', TempChunkO1(iRun),'rows'));
        ComboIndex_Plusone = find(ismember(E_O1ROUTES', TempChunkO1(iRun+1)','rows'));
        SumMatrix1(ComboIndex,ComboIndex_Plusone) = SumMatrix1(ComboIndex,ComboIndex_Plusone)+1;
    end
F_TransMatrix1= SumMatrix1./sum(SumMatrix1,2);
F_TransMatrix1(SumMatrix1==0) = 0/0; 
MaxTransValue1 = max(max(F_TransMatrix1));
NumSampled1 = sum(sum(F_TransMatrix1>0));
PropSampled1 = NumSampled1/numel(F_TransMatrix1);


SumMatrix2 = zeros(length(E_O2ROUTES),length(E_O2ROUTES));
F_TransMatrix2 = zeros(length(E_O2ROUTES),length(E_O2ROUTES));
OrderTransitions = length(TempChunkO2)-1; %needed to normalize
    for iRun = 1:OrderTransitions
        ComboIndex = find(ismember(E_O2ROUTES', TempChunkO2(:,iRun)','rows'));
        ComboIndex_Plusone = find(ismember(E_O2ROUTES', TempChunkO2(:,iRun+1)','rows'));
        SumMatrix2(ComboIndex,ComboIndex_Plusone) = SumMatrix2(ComboIndex,ComboIndex_Plusone)+1;
    end
F_TransMatrix2= SumMatrix2./sum(SumMatrix2,2);
F_TransMatrix2(SumMatrix2==0) = 0/0; 
MaxTransValue2 = max(max(F_TransMatrix2));
NumSampled2 = sum(sum(F_TransMatrix2>0));
PropSampled2 = NumSampled2/numel(F_TransMatrix2);



SumMatrix3 = zeros(length(E_O3ROUTES),length(E_O3ROUTES));
F_TransMatrix3 = zeros(length(E_O3ROUTES),length(E_O3ROUTES));
OrderTransitions = length(TempChunkO3)-1; %needed to normalize
    for iRun = 1:OrderTransitions
        ComboIndex = find(ismember(E_O3ROUTES', TempChunkO3(:,iRun)','rows'));
        ComboIndex_Plusone = find(ismember(E_O3ROUTES', TempChunkO3(:,iRun+1)','rows'));
        SumMatrix3(ComboIndex,ComboIndex_Plusone) = SumMatrix3(ComboIndex,ComboIndex_Plusone)+1;
    end
F_TransMatrix3= SumMatrix3./sum(SumMatrix3,2);
F_TransMatrix3(SumMatrix3==0) = 0/0; 
MaxTransValue3 = max(max(F_TransMatrix3));
NumSampled3 = sum(sum(F_TransMatrix3>0));
PropSampled3 = NumSampled3/numel(F_TransMatrix3);



SumMatrix4 = zeros(length(E_O4ROUTES),length(E_O4ROUTES));
F_TransMatrix4 = zeros(length(E_O4ROUTES),length(E_O4ROUTES));
OrderTransitions = length(TempChunkO4)-1; %needed to normalize
    for iRun = 1:OrderTransitions
        ComboIndex = find(ismember(E_O4ROUTES', TempChunkO4(:,iRun)','rows'));
        ComboIndex_Plusone = find(ismember(E_O4ROUTES', TempChunkO4(:,iRun+1)','rows'));
        SumMatrix4(ComboIndex,ComboIndex_Plusone) = SumMatrix4(ComboIndex,ComboIndex_Plusone)+1;
    end
F_TransMatrix4= SumMatrix4./sum(SumMatrix4,2);
F_TransMatrix4(SumMatrix4==0) = 0/0; 
MaxTransValue4 = max(max(F_TransMatrix4));
NumSampled4 = sum(sum(F_TransMatrix4>0));
PropSampled4 = NumSampled4/numel(F_TransMatrix4);

clear NumSampled* PropSampled* MaxTransValue* ComboIndex* SumMatrix* OrderTransitions iRun
% With returns 


SumMatrix1 = zeros(length(E_O1AllROUTES),length(E_O1AllROUTES));
F_TransMatrixAll1 = zeros(length(E_O1AllROUTES),length(E_O1AllROUTES));
OrderTransitions = length(TempChunkAllO1)-1; %needed to normalize
    for iRun = 1:OrderTransitions
        ComboIndex = find(ismember(E_O1AllROUTES', TempChunkAllO1(iRun),'rows'));
        ComboIndex_Plusone = find(ismember(E_O1AllROUTES', TempChunkAllO1(iRun+1)','rows'));
        SumMatrix1(ComboIndex,ComboIndex_Plusone) = SumMatrix1(ComboIndex,ComboIndex_Plusone)+1;
    end
F_TransMatrixAll1= SumMatrix1./sum(SumMatrix1,2);
F_TransMatrixAll1(SumMatrix1==0) = 0/0; 
MaxTransValue1 = max(max(F_TransMatrixAll1));
NumSampled1 = sum(sum(F_TransMatrixAll1>0));
PropSampled1 = NumSampled1/numel(F_TransMatrixAll1);


SumMatrix2 = zeros(length(E_O2AllROUTES),length(E_O2AllROUTES));
F_TransMatrixAll2 = zeros(length(E_O2AllROUTES),length(E_O2AllROUTES));
OrderTransitions = length(TempChunkAllO2)-1; %needed to normalize
    for iRun = 1:OrderTransitions
        ComboIndex = find(ismember(E_O2AllROUTES', TempChunkAllO2(:,iRun)','rows'));
        ComboIndex_Plusone = find(ismember(E_O2AllROUTES', TempChunkAllO2(:,iRun+1)','rows'));
        SumMatrix2(ComboIndex,ComboIndex_Plusone) = SumMatrix2(ComboIndex,ComboIndex_Plusone)+1;
    end
F_TransMatrixAll2= SumMatrix2./sum(SumMatrix2,2);
F_TransMatrixAll2(SumMatrix2==0) = 0/0; 
MaxTransValue2 = max(max(F_TransMatrixAll2));
NumSampled2 = sum(sum(F_TransMatrixAll2>0));
PropSampled2 = NumSampled2/numel(F_TransMatrixAll2);



SumMatrix3 = zeros(length(E_O3AllROUTES),length(E_O3AllROUTES));
F_TransMatrixAll3 = zeros(length(E_O3AllROUTES),length(E_O3AllROUTES));
OrderTransitions = length(TempChunkAllO3)-1; %needed to normalize
    for iRun = 1:OrderTransitions
        ComboIndex = find(ismember(E_O3AllROUTES', TempChunkAllO3(:,iRun)','rows'));
        ComboIndex_Plusone = find(ismember(E_O3AllROUTES', TempChunkAllO3(:,iRun+1)','rows'));
        SumMatrix3(ComboIndex,ComboIndex_Plusone) = SumMatrix3(ComboIndex,ComboIndex_Plusone)+1;
    end
F_TransMatrixAll3= SumMatrix3./sum(SumMatrix3,2);
F_TransMatrixAll3(SumMatrix3==0) = 0/0; 
MaxTransValue3 = max(max(F_TransMatrixAll3));
NumSampled3 = sum(sum(F_TransMatrixAll3>0));
PropSampled3 = NumSampled3/numel(F_TransMatrixAll3);



SumMatrix4 = zeros(length(E_O4AllROUTES),length(E_O4AllROUTES));
F_TransMatrixAll4 = zeros(length(E_O4AllROUTES),length(E_O4AllROUTES));
OrderTransitions = length(TempChunkAllO4)-1; %needed to normalize
    for iRun = 1:OrderTransitions
        ComboIndex = find(ismember(E_O4AllROUTES', TempChunkAllO4(:,iRun)','rows'));
        ComboIndex_Plusone = find(ismember(E_O4AllROUTES', TempChunkAllO4(:,iRun+1)','rows'));
        SumMatrix4(ComboIndex,ComboIndex_Plusone) = SumMatrix4(ComboIndex,ComboIndex_Plusone)+1;
    end
F_TransMatrixAll4= SumMatrix4./sum(SumMatrix4,2);
F_TransMatrixAll4(SumMatrix4==0) = 0/0; 
MaxTransValue4 = max(max(F_TransMatrixAll4));
NumSampled4 = sum(sum(F_TransMatrixAll4>0));
PropSampled4 = NumSampled4/numel(F_TransMatrixAll4);


clear TempChunk* NumSampled* PropSampled* MaxTransValue* ComboIndex* SumMatrix* OrderTransitions iRun
%% Calculate alternations for each run 

G_IsRightTurn = nan(3,length(B_All));
G_Quadrant = nan(1,length(B_All));
G_Return9 = nan(1,length(B_All));

for iRun = 1:length(B_All)
    thisRun = B_All(iRun);
    if thisRun == 1
        G_IsRightTurn(:,iRun) = [0,1,0];
        G_Quadrant(iRun) = 1;
    end
    if thisRun == 2
        G_IsRightTurn(:,iRun) = [0,1,1];
        G_Quadrant(iRun) = 1;
    end
    if thisRun == 3
        G_IsRightTurn(:,iRun) = [1,0,0];
        G_Quadrant(iRun) = 2;
    end
    if thisRun == 4
        G_IsRightTurn(:,iRun) = [1,0,1];
        G_Quadrant(iRun) = 2;
    end
    if thisRun == 5
        G_IsRightTurn(:,iRun) = [0,0,1];
        G_Quadrant(iRun) = 3;
    end
    if thisRun == 6
        G_IsRightTurn(:,iRun) = [0,0,0];
        G_Quadrant(iRun) = 3;
    end
    if thisRun == 7
        G_IsRightTurn(:,iRun) = [1,1,1];
        G_Quadrant(iRun) = 4;
    end
    if thisRun == 8
        G_IsRightTurn(:,iRun) = [1,1,0];
        G_Quadrant(iRun) = 4;
    end
    if thisRun == 9
        G_Return9(iRun) = 1;
    end
    if thisRun == 10
        G_Return9(iRun) = 0;
    end
end

G_AlternationTurn1 = nan(1,length(B_Runs));
G_AlternationTurn2 = nan(1,length(B_Runs));
G_AlternationTurnAny2 = nan(1,length(B_Runs));
G_AlternationTurn3 = nan(1,length(B_Runs));
G_AlternationTurnAny3 = nan(1,length(B_Runs));

isRun = find(sum(B_All==(1:NumRoutes),2));
isReturn = find(sum(B_All==[9,10],2));

G_IsRightTurn_IntOnly = G_IsRightTurn(:,isRun);
G_Quadrant_IntOnly= G_Quadrant(isRun);
G_Return9_ExtOnly = G_Return9(isReturn);


%Turn 1
for jRun = 2:size(G_IsRightTurn_IntOnly,2)
   
        thisTurn1 = G_IsRightTurn_IntOnly(1,jRun);
        lastTurn1 = G_IsRightTurn_IntOnly(1,jRun-1);
        if thisTurn1 == 1
            if lastTurn1 == 1
                G_AlternationTurn1(jRun) =0;
            end
            if lastTurn1 == 0
                G_AlternationTurn1(jRun) =1;
            end
                    
        end

        if thisTurn1 == 0
            if lastTurn1 == 1
                G_AlternationTurn1(jRun) =1;
            end
            if lastTurn1 == 0
                G_AlternationTurn1(jRun) =0;
            end

        end
end


%Turn 2 
rightsideIndex = find(G_IsRightTurn_IntOnly(1,:)==1);
leftsideIndex = find(G_IsRightTurn_IntOnly(1,:)==0);

%Specific Turn 
for jRun = 2:length(rightsideIndex)
    thisTurn2R = G_IsRightTurn_IntOnly(2,(rightsideIndex(jRun)));
    lastTurn2R = G_IsRightTurn_IntOnly(2,(rightsideIndex(jRun-1)));
        if thisTurn2R ==1 
            if lastTurn2R == 1
                G_AlternationTurn2(rightsideIndex(jRun)) =0;
            end
            if lastTurn2R == 0
                G_AlternationTurn2(rightsideIndex(jRun)) =1;
            end

        end
        if thisTurn2R ==0
            if lastTurn2R == 1
                G_AlternationTurn2(rightsideIndex(jRun)) =1;
            end
            if lastTurn2R == 0
                G_AlternationTurn2(rightsideIndex(jRun)) =0;
            end

        end
    
end
for jRun = 2:length(leftsideIndex)
    thisTurn2L = G_IsRightTurn_IntOnly(2,(leftsideIndex(jRun)));
    lastTurn2L = G_IsRightTurn_IntOnly(2,(leftsideIndex(jRun-1)));
        if thisTurn2L ==1 
            if lastTurn2L == 1
                G_AlternationTurn2(leftsideIndex(jRun)) =0;
            end
            if lastTurn2L == 0
                G_AlternationTurn2(leftsideIndex(jRun)) =1;
            end

        end
        if thisTurn2L ==0
            if lastTurn2L == 1
                G_AlternationTurn2(leftsideIndex(jRun)) =1;
            end
            if lastTurn2L == 0
                G_AlternationTurn2(leftsideIndex(jRun)) =0;
            end

        end
    
end


%Any turn 
for jRun = 2:size(G_IsRightTurn_IntOnly,2)
   
        thisTurn2 = G_IsRightTurn_IntOnly(2,jRun);
        lastTurn2 = G_IsRightTurn_IntOnly(2,jRun-1);
        if thisTurn2 == 1
            if lastTurn2 == 1
                G_AlternationTurnAny2(jRun) =0;
            end
            if lastTurn2 == 0
                G_AlternationTurnAny2(jRun) =1;
            end
                    
        end

        if thisTurn2 == 0
            if lastTurn2 == 1
                G_AlternationTurnAny2(jRun) =1;
            end
            if lastTurn2 == 0
                G_AlternationTurnAny2(jRun) =0;
            end

        end
end

%Turn 3
quad1Index = find(G_Quadrant_IntOnly(1,:)==1);
quad2Index = find(G_Quadrant_IntOnly(1,:)==2);
quad3Index = find(G_Quadrant_IntOnly(1,:)==3);
quad4Index = find(G_Quadrant_IntOnly(1,:)==4);

%Specific Turn 
for jRun = 2:length(quad1Index)
    thisTurn3A = G_IsRightTurn_IntOnly(3,(quad1Index(jRun)));
    lastTurn3A = G_IsRightTurn_IntOnly(3,(quad1Index(jRun-1)));
        if thisTurn3A ==1 
            if lastTurn3A == 1
                G_AlternationTurn3(quad1Index(jRun)) =0;
            end
            if lastTurn3A == 0
                G_AlternationTurn3(quad1Index(jRun)) =1;
            end

        end
        if thisTurn3A ==0
            if lastTurn3A == 1
                G_AlternationTurn3(quad1Index(jRun)) =1;
            end
            if lastTurn3A == 0
                G_AlternationTurn3(quad1Index(jRun)) =0;
            end

        end
    
end
for jRun = 2:length(quad2Index)
    thisTurn3B = G_IsRightTurn_IntOnly(3,(quad2Index(jRun)));
    lastTurn3B = G_IsRightTurn_IntOnly(3,(quad2Index(jRun-1)));
        if thisTurn3B ==1 
            if lastTurn3B == 1
                G_AlternationTurn3(quad2Index(jRun)) =0;
            end
            if lastTurn3B == 0
                G_AlternationTurn3(quad2Index(jRun)) =1;
            end

        end
        if thisTurn3B ==0
            if lastTurn3B == 1
                G_AlternationTurn3(quad2Index(jRun)) =1;
            end
            if lastTurn3B == 0
                G_AlternationTurn3(quad2Index(jRun)) =0;
            end

        end
    
end
for jRun = 2:length(quad3Index)
    thisTurn3C = G_IsRightTurn_IntOnly(3,(quad3Index(jRun)));
    lastTurn3C = G_IsRightTurn_IntOnly(3,(quad3Index(jRun-1)));
        if thisTurn3C ==1 
            if lastTurn3C == 1
                G_AlternationTurn3(quad3Index(jRun)) =0;
            end
            if lastTurn3C == 0
                G_AlternationTurn3(quad3Index(jRun)) =1;
            end

        end
        if thisTurn3C ==0
            if lastTurn3C == 1
                G_AlternationTurn3(quad3Index(jRun)) =1;
            end
            if lastTurn3C == 0
                G_AlternationTurn3(quad3Index(jRun)) =0;
            end

        end
    
end
for jRun = 2:length(quad4Index)
    thisTurn3D = G_IsRightTurn_IntOnly(3,(quad4Index(jRun)));
    lastTurn3D = G_IsRightTurn_IntOnly(3,(quad4Index(jRun-1)));
        if thisTurn3D ==1 
            if lastTurn3D == 1
                G_AlternationTurn3(quad4Index(jRun)) =0;
            end
            if lastTurn3D == 0
                G_AlternationTurn3(quad4Index(jRun)) =1;
            end

        end
        if thisTurn3D ==0
            if lastTurn3D == 1
                G_AlternationTurn3(quad4Index(jRun)) =1;
            end
            if lastTurn3D == 0
                G_AlternationTurn3(quad4Index(jRun)) =0;
            end

        end
    
end
%Any turn 
for jRun = 2:size(G_IsRightTurn_IntOnly,2)
   
        thisTurn3 = G_IsRightTurn_IntOnly(3,jRun);
        lastTurn3 = G_IsRightTurn_IntOnly(3,jRun-1);
        if thisTurn3 == 1
            if lastTurn3 == 1
                G_AlternationTurnAny3(jRun) =0;
            end
            if lastTurn3 == 0
                G_AlternationTurnAny3(jRun) =1;
            end
                    
        end

        if thisTurn3 == 0
            if lastTurn3 == 1
                G_AlternationTurnAny3(jRun) =1;
            end
            if lastTurn3 == 0
                G_AlternationTurnAny3(jRun) =0;
            end

        end
end

          G_PAlt_Turn1= nansum(G_AlternationTurn1)/(sum(~isnan(G_AlternationTurn1)));
          G_PAlt_Turn2Any= nansum(G_AlternationTurnAny2)/(sum(~isnan(G_AlternationTurnAny2)));
          G_PAlt_Turn3Any= nansum(G_AlternationTurnAny3)/(sum(~isnan(G_AlternationTurnAny3)));
          G_PAlt_Turn2Specific= nansum(G_AlternationTurn2)/(sum(~isnan(G_AlternationTurn2)));
          G_PAlt_Turn3Specific= nansum(G_AlternationTurn3)/(sum(~isnan(G_AlternationTurn3)));
          G_TotalRTurns = sum(sum(G_IsRightTurn==1));
          G_TotalLTurns = sum(sum(G_IsRightTurn==0));

clear thisRun jRun iRun thisTurn* lastTurn* isReturn isRun rightsideIndex leftsideIndex quad1Index quad2Index quad3Index quad4Index

%% Long/Short to or from routes 
isRun = find(sum(B_All==(1:NumRoutes),2));
isReturn = (sum(B_All==[9,10],2));
isReturnFollowingRun = zeros(1,length(isRun));
isReturnBeforeRun = zeros(1,length(isRun));


for iRun = 2:length(B_All)
    if isReturn(iRun) == 1
        if isReturn(iRun-1) ==0
            isReturnFollowingRun(iRun) = 1;
        end
    end
end
for iRun = 1:length(B_All)-1
    if isReturn(iRun) == 1
        if isReturn(iRun+1) ==0
            isReturnBeforeRun(iRun) = 1;
        end
    end
end
H_SameSideReturn = zeros(1,length(find(isReturnFollowingRun)));
H_OppSideReturn = zeros(1,length(find(isReturnFollowingRun)));
H_SameSideNextRun = zeros(1,length(find(isReturnBeforeRun)));
H_OppSideNextRun = zeros(1,length(find(isReturnBeforeRun)));
returnBeforeRunIndex = find(isReturnBeforeRun);
returnFollowingRunIndex = find(isReturnFollowingRun);

for jRun = 1:length(find(isReturnFollowingRun))
    
    thisReturn = (B_All(returnFollowingRunIndex(jRun)));
    previousRun = (B_All(returnFollowingRunIndex(jRun)-1));

    if previousRun == 1
        if thisReturn == 9 
            H_SameSideReturn(jRun) = 1 ;
        end
        if thisReturn == 10
            H_OppSideReturn(jRun) = 1 ;
        end

    end
    if previousRun == 2
        if thisReturn == 9 
            H_SameSideReturn(jRun) = 1 ;
        end
        if thisReturn == 10
            H_OppSideReturn(jRun) = 1 ;
        end
    end
    if previousRun == 3
        if thisReturn == 9 
            H_OppSideReturn(jRun) = 1 ;
        end
        if thisReturn == 10
            H_SameSideReturn(jRun) = 1 ;
        end
    end
    if previousRun == 4
        if thisReturn == 9 
            H_OppSideReturn(jRun) = 1 ;
        end
        if thisReturn == 10
            H_SameSideReturn(jRun) = 1 ;
        end
    end
    if previousRun == 5
        if thisReturn == 9 
            H_SameSideReturn(jRun) = 1 ;
        end
        if thisReturn == 10
            H_OppSideReturn(jRun) = 1 ;
        end
    end
    if previousRun == 6
        if thisReturn == 9 
            H_SameSideReturn(jRun) = 1 ;
        end
        if thisReturn == 10
            H_OppSideReturn(jRun) = 1 ;
        end
    end
    if previousRun == 7
        if thisReturn == 9 
            H_OppSideReturn(jRun) = 1 ;
        end
        if thisReturn == 10
            H_SameSideReturn(jRun) = 1 ;
        end
    end
    if previousRun == 8
        if thisReturn == 9 
            H_OppSideReturn(jRun) = 1 ;
        end
        if thisReturn == 10
            H_SameSideReturn(jRun) = 1 ;
        end
    end
end

for jRun = 1:length(find(isReturnBeforeRun))
    
    thisReturn = (B_All(returnBeforeRunIndex(jRun)));
    nextRun = (B_All(returnBeforeRunIndex(jRun)+1));

    if nextRun == 1
        if thisReturn == 9 
            H_SameSideNextRun(jRun) = 1 ;
        end
        if thisReturn == 10
            H_OppSideNextRun(jRun) = 1 ;
        end

    end
    if nextRun == 2
        if thisReturn == 9 
            H_SameSideNextRun(jRun) = 1 ;
        end
        if thisReturn == 10
            H_OppSideNextRun(jRun) = 1 ;
        end
    end
    if nextRun == 3
        if thisReturn == 9 
            H_OppSideNextRun(jRun) = 1 ;
        end
        if thisReturn == 10
            H_SameSideNextRun(jRun) = 1 ;
        end
    end
    if nextRun == 4
        if thisReturn == 9 
            H_OppSideNextRun(jRun) = 1 ;
        end
        if thisReturn == 10
            H_SameSideNextRun(jRun) = 1 ;
        end
    end
    if nextRun == 5
        if thisReturn == 9 
            H_SameSideNextRun(jRun) = 1 ;
        end
        if thisReturn == 10
            H_OppSideNextRun(jRun) = 1 ;
        end
    end
    if nextRun == 6
        if thisReturn == 9 
            H_SameSideNextRun(jRun) = 1 ;
        end
        if thisReturn == 10
            H_OppSideNextRun(jRun) = 1 ;
        end
    end
    if nextRun == 7
        if thisReturn == 9 
            H_OppSideNextRun(jRun) = 1 ;
        end
        if thisReturn == 10
            H_SameSideNextRun(jRun) = 1 ;
        end
    end
    if nextRun == 8
        if thisReturn == 9 
            H_OppSideNextRun(jRun) = 1 ;
        end
        if thisReturn == 10
            H_SameSideNextRun(jRun) = 1 ;
        end
    end
end

H_PShortReturn = sum(H_SameSideReturn)/length(H_SameSideReturn); 
H_PLongReturn = sum(H_OppSideReturn)/length(H_OppSideReturn);
H_PReturnSameSideNext = sum(H_SameSideNextRun)/length(H_SameSideNextRun);
H_PReturnOppSideNext = sum(H_OppSideNextRun)/length(H_OppSideNextRun);


clear iRun isRun isReturn isReturnFollowingRun isReturnBeforeRun jRun nextRun previousRun returnBeforeRunIndex returnFollowingRunIndex thisReturn
%% Perfect runs patterning 
routes = [1:NumRoutes];
routePerms = perms(routes);
isperfectblock = zeros(1,length(B_Blocks));
I_PermCounter = zeros(1,size(routePerms,1));

for iBlock = 1:length(B_Blocks)
        numrunsInThisBlock = numel(B_Blocks{iBlock});
        if numrunsInThisBlock == NumRoutes
            isperfectblock(iBlock) = 1;
        end
end
perfectblockIndex = find(isperfectblock);

if sum(isperfectblock)==0
    I_PerfBlocks=[];
    I_numPerfPatterns=[];
    I_maxChosenPatternCount=[];
end

if sum(isperfectblock)>0
    for jPerfBlock = 1:sum(isperfectblock)
        I_PerfBlocks(jPerfBlock,:) = B_Blocks{perfectblockIndex(jPerfBlock)};

        thispatternIndex = find(ismember(routePerms,I_PerfBlocks(jPerfBlock,:),'rows'));
        I_PermCounter(thispatternIndex) = I_PermCounter(thispatternIndex)+1;
    end

    I_numPerfPatterns = size(unique(I_PerfBlocks,'rows'),1); 
    I_maxChosenPatternCount = max(I_PermCounter);

end



clear routes routeperms isperfectblock numrunsInThisBlock
end