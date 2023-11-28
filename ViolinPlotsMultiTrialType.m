close all
% This FIRST case checks First Eye Blink Percent value at or after a 20% Threshold and the corresponding time

% Create violin plot for Time of Blink
lenTrials0 = size(Threshold_Table0.ThreshBlinkTimes(:,1),1);
lenTrials1 = size(Threshold_Table1.ThreshBlinkTimes(:,1),1);
lenTrials2 = size(Threshold_Table2.ThreshBlinkTimes(:,1),1);

nanAry1 = nan(lenTrials0 - lenTrials1,1);
nanAry2 = nan(lenTrials0 - lenTrials2,1);

cond0 = Threshold_Table0.ThreshBlinkTimes(:,1);
cond1 = [Threshold_Table1.ThreshBlinkTimes(:,1); nanAry1];
cond2 = [Threshold_Table2.ThreshBlinkTimes(:,1); nanAry2];

cond1US = Threshold_Table1.ThreshBlinkTimes(:,1);
cond2CS = Threshold_Table2.ThreshBlinkTimes(:,1); 

data = [cond0 cond1 cond2];
% vartable = horzcat(var(Threshold_Table0.EyePercent(:,1)), var(Threshold_Table1.EyePercent(:,1)), var(Threshold_Table2.EyePercent(:,1)))

figViolin = figure;
hold on;
% violin(data, 'FaceColor', 'red', 'EdgeColor', 'black', 'FaceAlpha', 0.75)
% violinplot(data, 'ShowData', false, 'ViolinAlpha', 0.5, 'BoxColor', 'k', 'MedianColor', 'r', 'WhiskerColor', 'k', 'Label', {'x', 'y', 'z'})
violin(data, 'FaceColor', [0.6, 0.6, 0.8], 'EdgeColor', 'none', 'ShowData', false, 'ViolinColor', [0.7, 0.7, 0.9]);

hold on 
%label = {'Mean CS+US','Mean US only','Mean CS only'};
%yline([mean(cond0) mean(condUS1) mean(condUS2)],'--k',label);
yline([mean(cond0) mean(cond1US) mean(cond2CS)],'-k');

CStime = -0.250
% EyePercentStats = myStatsAnalysis(data)
% Label axes
xlabel('Conditions')
ylabel('Times of Blink at Threshold')
% yline([puffTime CStime],'--.g',{'US Puff','CS Light'});
xticks(1:3)
xticklabels({'CS + US (0)', 'US only(1)','CS only(2)' })
title('Violin Plot of Time at Threshold vs. Mean Distributions');

yline(puffTime,'-.g','US Puff Start', 'LineWidth',1)
yline(CStime,'-.g','CS Light', 'LineWidth',1)

legend ('','Mean','Median','')

p = vartestn([cond0,cond1,cond2],'TestType','LeveneAbsolute');

if p > 0.05 % if variances are equal
    % Test for normality using Jarque-Bera test
    [~,p] = kstest([cond0,cond1,cond2]);

    if p > 0.05 % if data is normally distributed
        % Use parametric test, e.g. ANOVA
        [p,~,stats] = anova1([cond0,cond1,cond2]);
        if p < 0.05 % reject null hypothesis
            disp('Parametric ANOVA suggests significant differences between the groups');
        else
            disp('Parametric ANOVA does not suggest significant differences between the groups');
        end
    else % if data is not normally distributed
        % Use non-parametric test, e.g. Kruskal-Wallis test
        [p,~,stats] = kruskalwallis([cond0,cond1,cond2]);
        if p < 0.05 % reject null hypothesis
            disp('Non-parametric Kruskal-Wallis test suggests significant differences between the groups');
        else
            disp('Non-parametric Kruskal-Wallis test does not suggest significant differences between the groups');
        end
    end
else % if variances are not equal
    % Use non-parametric test, e.g. Friedman test
    [p,~,stats] = kruskalwallis([cond0,cond1,cond2]);
    if p < 0.05 % reject null hypothesis
        disp('Non-parametric Kruskal-Wwallis test suggests significant differences between the groups');
    else
        disp('Non-parametric Kruskal-Wallis test does not suggest significant differences between the groups');
    end
end


% More individual non-parametric tests
[pval_01, h_01] = ranksum(cond0, cond1, 'Alpha', 0.05);
[pval_02, h_02] = ranksum(cond0, cond2, 'Alpha', 0.05);
[pval_12, h_12] = ranksum(cond1, cond2, 'Alpha', 0.05);

% % Display the p-values in the figure
% text(1, max(max(cond0), max(cond1)), ['p_{01} = ' num2str(pval_01)])
% text(2, max(max(cond0), max(cond2)), ['p_{02} = ' num2str(pval_02)])
% text(3, max(max(cond1), max(cond2)), ['p_{12} = ' num2str(pval_12)])
% 

label = {"p_{01} = " + num2str(pval_01) "p_{02} = " + num2str(pval_02) "p_{12} = " + num2str(pval_12)};
yline([mean(cond0) mean(cond1US) mean(cond2CS)],'--k',label);
xticks(1:3)
xticklabels({'CS + US (0)', 'US only(1)','CS only(2)'})

% % Customize appearance
% axis tight
% set(gca,'XTick', [1,2,3,4,5,6,7,8], 'YLim', [0, 50], 'TickDir', 'out', 'Box', 'off')

% % Save plot
% saveas(gcf, 'violin_plot')
% exportgraphics(figViolin,'ViolinPlot.pdf', 'contenttype', 'vector','resolution', 600);

hold off




% SECOND case presents the Percent of Blink at the time of US at 0 ms
% Create violin plot for Time of Blink
lenTrials0 = size(Threshold_Table0.eyePerc(:,1),1);
lenTrials1 = size(Threshold_Table1.eyePerc(:,1),1);
lenTrials2 = size(Threshold_Table2.eyePerc(:,1),1);

nanAry1 = nan(lenTrials0 - lenTrials1,1);
nanAry2 = nan(lenTrials0 - lenTrials2,1);

cond0 = Threshold_Table0.eyePerc(:,1);
cond1 = [Threshold_Table1.eyePerc(:,1); nanAry1];
cond2 = [Threshold_Table2.eyePerc(:,1); nanAry2];

cond1US = Threshold_Table1.eyePerc(:,1);
cond2CS = Threshold_Table2.eyePerc(:,1); 

data = [cond0 cond1 cond2];

figViolin = figure;
hold on;
% violin(data, 'FaceColor', 'red', 'EdgeColor', 'black', 'FaceAlpha', 0.75)
violin(data, 'FaceColor', [0.6, 0.6, 0.8], 'EdgeColor', 'none', 'ShowData', false, 'ViolinColor', [0.7, 0.7, 0.9],'bw',2.5);

yline([mean(cond0) mean(cond1US) mean(cond2CS)],'-k');

% Label axes
xlabel('Conditions')
ylabel('Eye Percentage at US')
yline(threshold,'-.g','Threshold', 'LineWidth',1)


xticks(1:3)
xticklabels({'CS + US (0)', 'US only(1)','CS only(2)' })
title('Violin Plot of Eye Percentage at US vs Mean Distributions')
legend ('','Mean','Median','')

p = vartestn([cond0,cond1,cond2],'TestType','LeveneAbsolute');

if p > 0.05 % if variances are equal
    % Test for normality using Jarque-Bera test
    [~,p] = kstest([cond0,cond1,cond2]);

    if p > 0.05 % if data is normally distributed
        % Use parametric test, e.g. ANOVA
        [p,~,stats] = anova1([cond0,cond1,cond2]);
        if p < 0.05 % reject null hypothesis
            disp('Parametric ANOVA suggests significant differences between the groups');
        else
            disp('Parametric ANOVA does not suggest significant differences between the groups');
        end
    else % if data is not normally distributed
        % Use non-parametric test, e.g. Kruskal-Wallis test
        [p,~,stats] = kruskalwallis([cond0,cond1,cond2]);
        if p < 0.05 % reject null hypothesis
            disp('Non-parametric Kruskal-Wallis test suggests significant differences between the groups');
        else
            disp('Non-parametric Kruskal-Wallis test does not suggest significant differences between the groups');
        end
    end
else % if variances are not equal
    % Use non-parametric test, e.g. Friedman test
    [p,~,stats] = kruskalwallis([cond0,cond1,cond2]);
    if p < 0.05 % reject null hypothesis
        disp('Non-parametric Kruskal-Wwallis test suggests significant differences between the groups');
    else
        disp('Non-parametric Kruskal-Wallis test does not suggest significant differences between the groups');
    end
end

% More individual non-parametric tests
[pval_01, h_01] = ranksum(cond0, cond1, 'Alpha', 0.05);
[pval_02, h_02] = ranksum(cond0, cond2, 'Alpha', 0.05);
[pval_12, h_12] = ranksum(cond1, cond2, 'Alpha', 0.05);

% % Display the p-values in the figure
% text(1, max(max(cond0), max(cond1)), ['p_{01} = ' num2str(pval_01)])
% text(2, max(max(cond0), max(cond2)), ['p_{02} = ' num2str(pval_02)])
% text(3, max(max(cond1), max(cond2)), ['p_{12} = ' num2str(pval_12)])

label = {"p_{01} = " + num2str(pval_01) "p_{02} = " + num2str(pval_02) "p_{12} = " + num2str(pval_12)};
yline([mean(cond0) mean(cond1US) mean(cond2CS)],'--k',label);
yline(threshold,'-.g','Threshold', 'LineWidth',1)
xticks(1:3)
xticklabels({'CS + US (0)', 'US only(1)','CS only(2)'})

hold off;

stats0 = [
mean(Threshold_Table0.ThreshBlinkTimes(:,1)) 
    median(Threshold_Table0.ThreshBlinkTimes(:,1))
    std(Threshold_Table0.ThreshBlinkTimes(:,1))
    mean(Threshold_Table0.eyePerc(:,1)) 
    median(Threshold_Table0.eyePerc(:,1)) 
    std(Threshold_Table0.eyePerc(:,1))
]'

stats1 = [
mean(Threshold_Table1.ThreshBlinkTimes(:,1))
median(Threshold_Table1.ThreshBlinkTimes(:,1))
std(Threshold_Table1.ThreshBlinkTimes(:,1))
mean(Threshold_Table1.eyePerc(:,1))
median(Threshold_Table1.eyePerc(:,1))
std(Threshold_Table1.eyePerc(:,1))

]'

stats2 = [
mean(Threshold_Table2.ThreshBlinkTimes(:,1))
median(Threshold_Table2.ThreshBlinkTimes(:,1))
std(Threshold_Table2.ThreshBlinkTimes(:,1))
mean(Threshold_Table2.eyePerc(:,1))
median(Threshold_Table2.eyePerc(:,1))
std(Threshold_Table2.eyePerc(:,1))

]'
