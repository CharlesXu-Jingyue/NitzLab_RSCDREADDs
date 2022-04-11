RecNum = 12;
figure()
imagesc(BehaviorSeq.Runticker_Internals{RecNum}) 

figure()
bar(BehaviorSeq.Route1Prob{RecNum})
figure()
imagesc(BehaviorSeq.TransMatrix1{RecNum})
caxis([0 1])

close all

figure()
histogram(TurnAnalysis.PAlt_Turn1,100)

%% Pull data from drive
targetDir = '/Users/alveus/Documents/root/Documents/Code/LocalRepository/NitzLab_RSCDREADDs/BehavioralScoring';
cd(targetDir)
mkdir SP7
mkdir SP8
mkdir SP9
mkdir SP10
workDir = '/Volumes/TOSHIBA EXT/Research/NitzLab/RSC_DREADDs';
cd(workDir)
for i = 7:10
    cd("SP" + i)
    recs = dir('Rec*');
    for j = 1:size(recs,1)
        recNames = string({recs.name});
        cd(recNames(1,j))
        dvts = dir('*.DVT');
        dvtNames = string({dvts.name});
        for k = 1:size(dvtNames,2)
            if extractBetween(dvtNames(1,k),7,9) == "SP7"
                copyfile(dvtNames(1,k),targetDir + "/SP7",'f')
            elseif extractBetween(dvtNames(1,k),7,9) == "SP8"
                copyfile(dvtNames(1,k),targetDir + "/SP8",'f')
            elseif extractBetween(dvtNames(1,k),7,9) == "SP9"
                copyfile(dvtNames(1,k),targetDir + "/SP9",'f')
            elseif extractBetween(dvtNames(1,k),7,9) == "SPX"
                copyfile(dvtNames(1,k),targetDir + "/SP10",'f')
            end
        end
        cd ..
    end
    cd ..
end