close all
% This FIRST case checks First Eye Blink Percent value at or after a 20% Threshold and the corresponding time

% Create violin plot for Time of Blink
lenTrials0 = size(Threshold_Table0.ThreshBlinkTimes(:,1),1);
cond0 = Threshold_Table0.ThreshBlinkTimes(:,1);
data = [cond0];

% Starts to plot violin figure
figViolin = figure;
hold on;
violin(data, 'FaceColor', [0.6, 0.6, 0.8], 'EdgeColor', 'none', 'ShowData', false, 'ViolinColor', [0.7, 0.7, 0.9]);

hold on
CStime = -0.250
puffTime = 0
yline([mean(cond0)],'-k'); % Adds a black line at the mean
%yline([puffTime CStime],'--.g',{'US Puff','CS Light'});
xlabel('Conditions');
ylabel('Times of Blink at Threshold');
xticklabels({'CS + US (0)'});
title('Violin Plot of Time at Threshold vs. Mean Distributions');
yline(puffTime,'-.g','US Puff Start', 'LineWidth',1);
yline(CStime,'-.g','CS Light ', 'LineWidth',1);
legend ('','Mean','Median','');

% Runs non parametric test
p = vartestn([cond0],'TestType','LeveneAbsolute');

if p > 0.05 % if variances are equal
    % Test for normality using Jarque-Bera test
    [~,p] = jbtest([cond0]);

    if p > 0.05 % if data is normally distributed
        % Use parametric test, e.g. ANOVA
        [p,~,stats] = anova1([cond0]);
        if p < 0.05 % reject null hypothesis
            disp('Parametric ANOVA suggests significant differences between the groups');
        else
            disp('Parametric ANOVA does not suggest significant differences between the groups');
        end
    else % if data is not normally distributed
        % Use non-parametric test, e.g. Kruskal-Wallis test
        [p,~,stats] = kruskalwallis([cond0]);
        if p < 0.05 % reject null hypothesis
            disp('Non-parametric Kruskal-Wallis test suggests significant differences between the groups');
        else
            disp('Non-parametric Kruskal-Wallis test does not suggest significant differences between the groups');
        end
    end
else % if variances are not equal
    % Use non-parametric test, e.g. Friedman test
    [p,~,stats] = kruskalwallis([cond0]);
    if p < 0.05 % reject null hypothesis
        disp('Non-parametric Kruskal-Wwallis test suggests significant differences between the groups');
    else
        disp('Non-parametric Kruskal-Wallis test does not suggest significant differences between the groups');
    end
end
hold off


% SECOND case presents the Percent of Blink at the time of US at 0.250 ms

% Create violin plot for Time of Blink
lenTrials0 = size(Threshold_Table0.eyePerc(:,1),1);
cond0 = Threshold_Table0.eyePerc(:,1);
data = [cond0];

figViolin = figure;
hold on;
violin(data, 'FaceColor', [0.6, 0.6, 0.8], 'EdgeColor', 'none', 'ShowData', false, 'ViolinColor', [0.7, 0.7, 0.9],'bw',2.5);

% Label axes
yline([mean(cond0)],'-k');
yline(threshold,'-.g','Threshold', 'LineWidth',1)
xlabel('Conditions')
ylabel('Eye Percentage at US')
xticklabels({'CS + US (0)' })
title('Violin Plot of Eye Percentage at US vs Mean Distributions')
legend ('','Mean','Median','')

p = vartestn([cond0],'TestType','LeveneAbsolute');

if p > 0.05 % if variances are equal
    % Test for normality using Jarque-Bera test
    [~,p] = jbtest([cond0]);

    if p > 0.05 % if data is normally distributed
        % Use parametric test, e.g. ANOVA
        [p,~,stats] = anova1([cond0]);
        if p < 0.05 % reject null hypothesis
            disp('Parametric ANOVA suggests significant differences between the groups');
        else
            disp('Parametric ANOVA does not suggest significant differences between the groups');
        end
    else % if data is not normally distributed
        % Use non-parametric test, e.g. Kruskal-Wallis test
        [p,~,stats] = kruskalwallis([cond0]);
        if p < 0.05 % reject null hypothesis
            disp('Non-parametric Kruskal-Wallis test suggests significant differences between the groups');
        else
            disp('Non-parametric Kruskal-Wallis test does not suggest significant differences between the groups');
        end
    end
else % if variances are not equal
    % Use non-parametric test, e.g. Friedman test
    [p,~,stats] = kruskalwallis([cond0]);
    if p < 0.05 % reject null hypothesis
        disp('Non-parametric Kruskal-Wwallis test suggests significant differences between the groups');
    else
        disp('Non-parametric Kruskal-Wallis test does not suggest significant differences between the groups');
    end
end

yline(threshold,'-.g','Threshold', 'LineWidth',1)

hold off;

stats = [
    mean(Threshold_Table0.ThreshBlinkTimes(:,1)) 
    median(Threshold_Table0.ThreshBlinkTimes(:,1))
    std(Threshold_Table0.ThreshBlinkTimes(:,1))
    mean(Threshold_Table0.eyePerc(:,1)) 
    median(Threshold_Table0.eyePerc(:,1)) 
    std(Threshold_Table0.eyePerc(:,1))]'



