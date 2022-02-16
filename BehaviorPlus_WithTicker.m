%Advanced Behavioral Analyses 
% %% load in data
% load 'Keyboard1' ;
Runs = indRecStruct.events ;
Behavior = struct ;

%% Create timepoints for each trial 
Behavior.Timestamps = indRecStruct.processedDVT(:,2);

c = 1; 
for i = 1:length(indRecStruct.events)
    if abs(indRecStruct.events(i,3))>=1 && (abs(indRecStruct.events(i,3))<50)
Behavior.starts(c,1) = indRecStruct.events(i,1);
Behavior.starts(c,2) = indRecStruct.events(i,2);
Behavior.starts(c,3) = abs(indRecStruct.events(i,3));
c = c+1;
    end
end

c = 1; 
for i = 1:length(indRecStruct.events)
    if abs(indRecStruct.events(i,3))>=100 && (abs(indRecStruct.events(i,3))<150)
Behavior.ends(c,1) = indRecStruct.events(i,1);
Behavior.ends(c,2) = indRecStruct.events(i,2);
Behavior.ends(c,3) = abs(indRecStruct.events(i,3));
c = c+1;
    end
end
Behavior.starts = sortrows (Behavior.starts,2);
Behavior.ends = sortrows (Behavior.ends,2);

for j = 1:length(Behavior.starts)
    p = Behavior.Timestamps(:)>=Behavior.starts(j,2) & Behavior.Timestamps <= Behavior.ends(j,2);
	Behavior.Runtimes{j,1}=Behavior.Timestamps(p);
end

for k = 1:length(Behavior.starts(:,3))
    Behavior.Runtimes{k,2}=Behavior.starts(k,3);
end
clear j p i c k

%% Create blocks of trials 
j = find(Behavior.starts(:,3)>=1&Behavior.starts(:,3)<=8);
k = find(Behavior.starts(:,3)>=9&Behavior.starts(:,3)<=10);
Behavior.Trials.Runs(:,1) = Behavior.starts(j,3);
Behavior.Trials.Returns(:,2) = Behavior.starts(k,3);
clear j k

goodbad = [];
j = 1;
p = 1;
k = zeros(4,1);

for i=1:length(Behavior.Trials.Runs)
    Behavior.Trials.Blocks{j}(1,p) = Behavior.Trials.Runs(i);
    p=p+1;
    if Behavior.Trials.Runs(i) == 1
        if k(1,1)==0
            goodbad(i) = sum(k)+1;
        end
        if k(1,1)==1
            goodbad(i) = 100;
        end
        k(1,1) = 1;
    end
    if Behavior.Trials.Runs(i) == 2
        if k(2,1)==0
            goodbad(i) = sum(k)+1;
        end
        if k(2,1)==1
            goodbad(i) = 100;
        end
        k(2,1) = 1;
    end
    if Behavior.Trials.Runs(i) == 3
        if k(3,1)==0
            goodbad(i) = sum(k)+1;
        end
        if k(3,1)==1
            goodbad(i) = 100;
        end
        k(3,1) = 1;
    end
    if Behavior.Trials.Runs(i) == 4
        if k(4,1)==0
            goodbad(i) = sum(k)+1;
        end
        if k(4,1)==1
            goodbad(i) = 100;
        end
        k(4,1) = 1;
    end
    k;
    if sum(k) == 4 
        j = j+1;
        p=1;
        k = zeros(4,1);
    end
end

Behavior.Trials.ErrorOrNot = goodbad;

runticker = zeros(length(Behavior.Trials.Runs),length(unique(Behavior.Trials.Runs)));

for i = 1:length(Behavior.Trials.Runs)
    runticker(i,(Behavior.Trials.Runs(i))) = (Behavior.Trials.ErrorOrNot(i));
end
Behavior.RunTicker = runticker;


for i=1:length(Behavior.Trials.Blocks)
    Behavior.Trials.NumRuns(i) = numel(Behavior.Trials.Blocks{i});
    if numel(Behavior.Trials.Blocks{i}) <4
        Behavior.Trials.Blocks(i) = [];
    end

    Behavior.Trials.NumErrors(i) =(Behavior.Trials.NumRuns(i))-4; %ONLY WORKS FOR 4 rewards
    
    if Behavior.Trials.NumErrors(i)<0
        Behavior.Trials.NumErrors(i) = 0;
    end
end
Behavior.Trials.PerfectPercent = ((length(find(Behavior.Trials.NumErrors==0))/(length(Behavior.Trials.Blocks)))*100);
Behavior.Trials.MeanErrors = ((sum(Behavior.Trials.NumErrors))/(length(Behavior.Trials.Blocks)));


%% Probabilities regardless of block completion for all four reward sites

totalRuns = length(Behavior.Trials.Runs); %Comment out this part if using dummy data
matrixOfVals = zeros(4,5); %Initialize a matrix where all the totals will be stored
%Note: the structure of this matrix should be in this format:
%       Totals 1 2 3 4
% 1     [               ]
% 2     [               ]
% 3     [               ]
% 4     [               ]
i = 1;

while i < totalRuns %Once we reach the last run, aka when i = totalRuns, there is nothing after that run so we can’t compare it to anything. Therefore, we stop at the second to last run.
    for site = 1:4
        if Behavior.Trials.Runs(i) == site
            matrixOfVals(site,1) = matrixOfVals(site,1) + 1; %Add onto the total number of times the rat goes to this reward site
            if Behavior.Trials.Runs(i+1) == 1
                matrixOfVals(site,2) = matrixOfVals(site,2) + 1;
            elseif Behavior.Trials.Runs(i+1) == 2
                matrixOfVals(site,3) = matrixOfVals(site,3) + 1;
            elseif Behavior.Trials.Runs(i+1) == 3
                matrixOfVals(site,4) = matrixOfVals(site,4) + 1;
            elseif Behavior.Trials.Runs(i+1) == 4
                matrixOfVals(site,5) = matrixOfVals(site,5) + 1 ;
            end
        else
            continue
        end
    end
i = i + 1; %Once we’ve recorded whatever reward site this time, we move on to the next run
end

probabilities1234 = [ matrixOfVals(1,2)/matrixOfVals(1,1) matrixOfVals(1,3)/matrixOfVals(1,1) matrixOfVals(1,4)/matrixOfVals(1,1) matrixOfVals(1,5)/matrixOfVals(1,1) ; ...
matrixOfVals(2,2)/matrixOfVals(2,1) matrixOfVals(2,3)/matrixOfVals(2,1) matrixOfVals(2,4)/matrixOfVals(2,1) matrixOfVals(2,5)/matrixOfVals(2,1) ; ...
matrixOfVals(3,2)/matrixOfVals(3,1) matrixOfVals(3,3)/matrixOfVals(3,1) matrixOfVals(3,4)/matrixOfVals(3,1) matrixOfVals(3,5)/matrixOfVals(3,1) ; ...
matrixOfVals(4,2)/matrixOfVals(4,1) matrixOfVals(4,3)/matrixOfVals(4,1) matrixOfVals(4,4)/matrixOfVals(4,1) matrixOfVals(4,5)/matrixOfVals(4,1) ];

%% Probabilities for right vs. left

totalRuns = length(Behavior.Trials.Runs); %Comment out this part if using dummy data
matrixOfVals = zeros(2,3);
%Note: the structure of this matrix should be in this format:
%       Totals    Left    Right
% Left [                       ]
% Right[                       ]

i = 1;
while i < totalRuns %Once we reach the last run, aka when i = totalRuns, there is nothing after that run so we can’t compare it to anything. Therefore, we stop at the second to last run.
    if Behavior.Trials.Runs(i) == 1 || Behavior.Trials.Runs(i) == 2
        matrixOfVals(1,1) = matrixOfVals(1,1) + 1; %Add onto the total number of times the rat goes to the left side
        if Behavior.Trials.Runs(i+1) == 1 || Behavior.Trials.Runs(i+1) == 2 %The rat goes to the left side after already going to the left before.
            matrixOfVals(1,2) = matrixOfVals(1,2) + 1;
        elseif Behavior.Trials.Runs(i+1) == 3 || Behavior.Trials.Runs(i+1) == 4 %The rat goes to the right side after already going to the left before.
            matrixOfVals(1,3) = matrixOfVals(1,3) + 1;
        end
    elseif Behavior.Trials.Runs(i) == 3 || Behavior.Trials.Runs(i) == 4
        matrixOfVals(2,1) = matrixOfVals(2,1) + 1; %Add onto the total number of times the rat goes to the right side
        if Behavior.Trials.Runs(i+1) == 1 || Behavior.Trials.Runs(i+1) == 2 %The rat goes to the left side after going to the right first.
            matrixOfVals(2,2) = matrixOfVals(2,2) + 1;
        elseif Behavior.Trials.Runs(i+1) == 3 || Behavior.Trials.Runs(i+1) == 4 %The rat goes to the right side after already going to the right before.
            matrixOfVals(2,3) = matrixOfVals(2,3) + 1;
        end
    end
i = i + 1; %Once we’ve recorded whatever reward site this time, we move on to the next run
end

probabilities_rightvsleft = [ matrixOfVals(1,2)/matrixOfVals(1,1) matrixOfVals(1,3)/matrixOfVals(1,1) ; ...
matrixOfVals(2,2)/matrixOfVals(2,1) matrixOfVals(2,3)/matrixOfVals(2,1) ] ;



%%
%PShort V Long

if length(Behavior.Trials.Runs) <= length(Behavior.Trials.Returns); %more returns than runs 
    completeruns = length(Behavior.Trials.Runs);
else
    completeruns = length(Behavior.Trials.Returns); %use whichever is smaller;
end
Runindex = find(Behavior.starts(:,3)<9);
Returnindex = find(Behavior.starts(:,3)>=9);
firstReturnindex = min(Behavior.starts(Returnindex,2));
firstRunindex = min(Behavior.starts(Runindex,2));

if firstRunindex < firstReturnindex
    nooffset = 1; %animal did run then return
else
    nooffset = 2 %animal did not run a path before running a return route (running perimeter) 
end

if nooffset == 2 
    Returnindex(1) = [] %set to arbitrarily large number so this is no longer the min
    firstReturnindex = min(Behavior.starts(Returnindex,2));
end

RunDecoder = Behavior.starts(Runindex,3);
ReturnDecoder = Behavior.starts(Returnindex,3);

for i = 1:length(Behavior.starts);
    if Behavior.starts(i,3)>=9;
        IsRun(i) = 2; %1 = run| 2 = return ;
    else
        
        if Behavior.starts(i,3)<9;
            IsRun(i) = 1;
        end
    end
end
IsRun = IsRun';
for i = 1:(length(IsRun)-1);
    if IsRun(i) == 1 
        if IsRun(i+1) == 2 
            RunFollowedByReturn(i) = 1;
        else
            RunFollowedByReturn(i) = 0; 
        end
    end
end
RunFollowedByReturn = RunFollowedByReturn';

for i = 1:(length(Behavior.starts)); %1 = Right 2 = Left
   if Behavior.starts(i,3)== 1
        LRDecoder(i) = 1;
   else
   if Behavior.starts(i,3)==2
        LRDecoder(i) = 1;
   else
   if Behavior.starts(i,3)== 3
        LRDecoder(i) = 2;
   else
   if Behavior.starts(i,3)==4
        LRDecoder(i) = 2;
   else
        LRDecoder(i) = 0;
   end
   end
   end
   end
end
LRDecoder=LRDecoder';

for i = 1:length(RunFollowedByReturn) % 1 = L | 2 = R| 3 = short| 4 = long
    if LRDecoder(i)== 1 %if left
        LongShortDecider = Behavior.starts(i+1,3);
        if LongShortDecider == 9 
            LongShortDecoder(i,1) = 3
        else
            if LongShortDecider ==10
                LongShortDecoder(i,1) = 4
            end
        end
    else 
        if LRDecoder(i)== 2 %if Right
            LongShortDecider = Behavior.starts(i+1,3);
        if LongShortDecider == 9 
            LongShortDecoder(i,1) = 4
        else
            if LongShortDecider ==10
                LongShortDecoder(i,1) = 3
            end
        end
        end
    end
end

CountRunsFollowedByReturns = sum(RunFollowedByReturn)
CountShort = length(find(LongShortDecoder == 3));
CountLong = length(find(LongShortDecoder == 4));
PShort = CountShort/CountRunsFollowedByReturns;
PLong =  CountLong/CountRunsFollowedByReturns;

%%
%Perfect Run Pattern Stability 
%Make Fraction of Perfect Runs that share same pattern as first perfect run


PerfRunsSame=0;
NumPerfect=0;

if (find(Behavior.Trials.NumErrors(1:length(Behavior.Trials.Blocks)) ==0)) > 0
PerfFinder = find(Behavior.Trials.NumErrors(1:length(Behavior.Trials.Blocks)) ==0);
NumPerfect = length(PerfFinder);
FirstPerfect = Behavior.Trials.Blocks{min(PerfFinder)};

j = 1; 
for i = PerfFinder
    PerfectIndex = Behavior.Trials.Blocks{i};
    if PerfectIndex == FirstPerfect; 
        PerfRunsSame = PerfRunsSame+1;
    else 
        DeviantPerfectRuns{j} = PerfectIndex;
        j=j+1
    end
end

a = exist('DeviantPerfectRuns')
if a > 0
    Behavior.Trials.PerfRuns_DeviantFromFirst = DeviantPerfectRuns;
end

else 
    FractionSame = 0 
end


FractionSame = PerfRunsSame/NumPerfect;

Behavior.Trials.NumPerfect = NumPerfect; 
Behavior.Trials.PerfRunsFraction_SameAsFirstPerf = FractionSame;

%%
%
Behavior.Prob.Path1FromPath1 = probabilities1234(1,1);
Behavior.Prob.Path2FromPath1 = probabilities1234(1,2);
Behavior.Prob.Path3FromPath1 = probabilities1234(1,3);
Behavior.Prob.Path4FromPath1 = probabilities1234(1,4);
Behavior.Prob.Path1FromPath2 = probabilities1234(2,1);
Behavior.Prob.Path2FromPath2 = probabilities1234(2,2);
Behavior.Prob.Path3FromPath2 = probabilities1234(2,3);
Behavior.Prob.Path4FromPath2 = probabilities1234(2,4);
Behavior.Prob.Path1FromPath3 = probabilities1234(3,1);
Behavior.Prob.Path2FromPath3 = probabilities1234(3,2);
Behavior.Prob.Path3FromPath3 = probabilities1234(3,3);
Behavior.Prob.Path4FromPath3 = probabilities1234(3,4);
Behavior.Prob.Path1FromPath4 = probabilities1234(4,1);
Behavior.Prob.Path2FromPath4 = probabilities1234(4,2);
Behavior.Prob.Path3FromPath4 = probabilities1234(4,3);
Behavior.Prob.Path4FromPath4 = probabilities1234(4,4);
Behavior.Prob.LeftFromLeft = probabilities_rightvsleft(1,1);
Behavior.Prob.LeftFromRight = probabilities_rightvsleft(2,1);
Behavior.Prob.RightFromRight = probabilities_rightvsleft(2,2);
Behavior.Prob.RightFromLeft = probabilities_rightvsleft(1,2);
Behavior.Prob.PShort = PShort;
Behavior.Prob.PLong = PLong;



%%
%%Indexed probabilities 
%Create key 
P_Index{1,1} = [1,2,3,4];
P_Index{2,1} = [1,2,4,3];
P_Index{3,1} = [1,3,2,4];
P_Index{4,1} = [1,3,4,2];
P_Index{5,1} = [1,4,3,2];
P_Index{6,1} = [1,4,2,3];
P_Index{7,1} = [2,1,3,4];
P_Index{8,1} = [2,1,4,3];
P_Index{9,1} = [2,3,1,4];
P_Index{10,1} = [2,3,4,1];
P_Index{11,1} = [2,4,1,3];
P_Index{12,1} = [2,4,3,1];
P_Index{13,1} = [3,1,2,4];
P_Index{14,1} = [3,1,4,2];
P_Index{15,1} = [3,2,1,4];
P_Index{16,1} = [3,2,4,1];
P_Index{17,1} = [3,4,1,2];
P_Index{18,1} = [3,4,2,1];
P_Index{19,1} = [4,1,2,3];
P_Index{20,1} = [4,1,3,2];
P_Index{21,1} = [4,2,1,3];
P_Index{22,1} = [4,2,3,1];
P_Index{23,1} = [4,3,1,2];
P_Index{24,1} = [4,3,2,1];
P_Index{1,2} = ["A1"];
P_Index{2,2} = ["A2"];
P_Index{3,2} = ["A3"];
P_Index{4,2} = ["A4"];
P_Index{5,2} = ["A5"];
P_Index{6,2} = ["A6"];
P_Index{7,2} = ["B1"];
P_Index{8,2} = ["B2"];
P_Index{9,2} = ["B3"];
P_Index{10,2} = ["B4"];
P_Index{11,2} = ["B5"];
P_Index{12,2} = ["B6"];
P_Index{13,2} = ["C1"];
P_Index{14,2} = ["C2"];
P_Index{15,2} = ["C3"];
P_Index{16,2} = ["C4"];
P_Index{17,2} = ["C5"];
P_Index{18,2} = ["C6"];
P_Index{19,2} = ["D1"];
P_Index{20,2} = ["D2"];
P_Index{21,2} = ["D3"];
P_Index{22,2} = ["D4"];
P_Index{23,2} = ["D5"];
P_Index{24,2} = ["D6"];
%%
%For perfect runs only 
%What is pattern create counts for each pattern 
if (find(Behavior.Trials.NumErrors(1:length(Behavior.Trials.Blocks)) ==0)) > 0

    P_ThisRecording=P_Index; 

for P_Runs = 1:length(P_ThisRecording)
    P_ThisRecording{P_Runs, 3} = [0];
end

for P_i = PerfFinder
    PerfectIndex = Behavior.Trials.Blocks{P_i};
        for P_j = 1:length(P_ThisRecording) 
            P_k = cell2mat(P_ThisRecording(P_j,1));
             if PerfectIndex == P_k; 
             P_ThisRecording{P_j,3} = P_ThisRecording{P_j,3}+1 ;
             end
        end
end


P_ProbEach = 1/(length(P_ThisRecording));  %Probability of any given run. 

for P_i = 1:length(P_ThisRecording)
    P_ThisRecording{P_i,4} = (P_ProbEach^(P_ThisRecording{P_i,3})); %Probability of perfect for each 
    P_ThisRecording{P_i,5} = P_ThisRecording{P_i,4}/(1-(P_ThisRecording{P_i,4})); %Odds for each
    if P_ThisRecording{P_i,4} == 1 
        P_ThisRecording{P_i,4} = nan;
        P_ThisRecording{P_i,5} = nan;
    end
end

P_P_Compare = cell2mat(P_ThisRecording(:,3));
P_max = max(P_P_Compare);
P_total = sum(P_P_Compare);
P_rest = (P_total-P_max);
P_DougProb = ((P_max-P_rest)/(P_total));
P_Prob2 = P_max/P_total;

P_Percent = (P_max/P_total);

Behavior.PerfectIndex.MaxBinPercent = P_Percent;
Behavior.PerfectIndex.Distribution = P_ThisRecording;
Behavior.PerfectIndex.Prob = P_DougProb;
Behavior.PerfectIndex.Prob2 = P_Prob2;

else
    Behavior.PerfectIndex.Distribution = []
    Behavior.PerfectIndex.Prob = nan;
    Behavior.PerfectIndex.Prob2 = nan;
    Behavior.PerfectIndex.MaxBinPercent = 0; 
    
end

Behavior.ErrorLists = Behavior.Trials.NumErrors;

clearvars -except Behavior* f e d file* Rat* Rec* Analysis* indRec*
%save 'Behavioral_Stats'

imagesc(Behavior.RunTicker)
    
