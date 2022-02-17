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