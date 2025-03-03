%% Make plots for turn analysis %%
%
% Charles Xu @ UCSD, 20220221
%
% This code is intended for completing all of the plotting of turn analysis
% figures
%
% Run TurnAnalysis_MakeStats.m before running this code
%
%% Main %%

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

%% Make histogram for distribution of probabilities
% figure
% set(gcf,'Position',[10 10 1000 1000])
% 

