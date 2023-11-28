close all
% Allows to select the data file for analysis and plotting';
[file,path] = uigetfile('*.mat');
fullPath = fullfile(path, file);
load(fullPath);
% load ("C:\Users\aabub\OneDrive\Desktop\JuanData\WT\MLI\Day 15\Female\F5\Day15GC_005_042722_Trial_Table.mat")

rows0 = (Trial_Table.TypeTrial==0); % CS+US
TrialTable_0 = Trial_Table(rows0,:);

rows1 = (Trial_Table.TypeTrial==1); 
TrialTable_1 = Trial_Table(rows1,:); % US only

rows2 = (Trial_Table.TypeTrial==2);
TrialTable_2 = Trial_Table(rows2,:); % CS only

% Plot 3 diffrnt figures for each Trial Type from each Trial Table 0, 1 & 2

figure
hold on
idx0 = [];
eyePerc0 = [];
puffTimeAtPerc0 = [];

threshtimes0 = []; %Create empty arrays to make threshold table in the loop.
eyePercent0 = [];
indices0 = [];
for i=1:size(TrialTable_0)
eyeBlinkTimeArray = (getArrayFromByteStream(TrialTable_0.EyeBlinkTimeArray(i,:)));
eyeBlinkPercent = (getArrayFromByteStream(TrialTable_0.EyeBlinkPerc(i,:)))*100; %*100 to y values as percents

%time = linspace(TrialTable_0.StartEyeVid(i,1)-TrialTable_0.StartTrial(i,1),250*0.0052 + TrialTable_0.StartEyeVid(i,1)-TrialTable_0.StartTrial(i,1),250);
time = linspace(-(170-1)*0.0052,(250 - 170)*0.0052,250);
% Time for the x axis plot spaced out using linspace by 250 x 0.0052
% (0.0052 framerate) where startEyeVid is start of the time and startTrial
% is the time of the CS.

puffTime = 0; % in ms
xline(puffTime, '--m','LineWidth',3);
threshold = 20;
yline(threshold,'-.g'); % Eye Blink Threshold at 20%

CStime = -0.250;
% Find the indexes at cutoff point
cutoff = find(time >= CStime,1);

% Exlude the data points above the threshold at the CS time cutoff
if eyeBlinkPercent(cutoff)> threshold
    eyeBlinkPercent(cutoff(eyeBlinkPercent(cutoff)> threshold)) = NaN;

else

% Percent of Blink at the time of US at 0 ms
time2 = time'; % Transposes the table and assigns to time2
numspuffTime = find(time2 >= puffTime,1); % finds first index at or before 0.250 ms
idx0 = [idx0 numspuffTime];
idx = idx0';
eyePerc0 = [eyePerc0 eyeBlinkPercent(numspuffTime)];
eyePerc = eyePerc0';
puffTimeAtPerc0 = [puffTimeAtPerc0 time2(numspuffTime)];
puffTimeAtPerc = puffTimeAtPerc0';
% PercAtPuffTimeTable = cat(2, table(idx), table(eyePerc), table(puffTimeAtPerc));

% First Eye Blink Percent value at or after a 20% Threshold and the
% corresponding time
numsEye = find(eyeBlinkPercent(time>-0.1) >= threshold,1); % finds first index at which threshold exceeded
diff = length(eyeBlinkPercent)-length(eyeBlinkPercent(time>-0.1));

indices0 = [indices0, numsEye+diff];
Indices = indices0';
eyePercent0 = [eyePercent0 eyeBlinkPercent(numsEye+diff)];
EyePercent = eyePercent0';
threshtimes0 = [threshtimes0, time(numsEye+diff)]; % eyeBlinkTimeArray(nums)-startTrial to get normalized values 
ThreshBlinkTimes = threshtimes0';
Threshold_Table0 = cat(2, table(Indices), table(EyePercent), table(ThreshBlinkTimes), ... 
    table(idx), table(eyePerc), table(puffTimeAtPerc)); %Table created for post thresh parameters 

title ("Mouse Blink Behavior (Trial Type 0)");
   plot(time, eyeBlinkPercent, '-b', 'LineWidth', 2)
   xline([CStime puffTime],'--') % xlabel = {'Light Time (CS)','Puff Time (US)'};
   xlabel("Trial Time")
   ylabel("Eye Closure Percentage")
end
end
hold off



% figures below follow the same code as above just different trial
% conditions like 0, 1 and 2.

figure
hold on
idx1 = [];
eyePerc1 = [];
puffTimeAtPerc1 = [];

threshtimes1 = [];
eyePercent1 = [];
indices1 = [];
for i=1:size(TrialTable_1)
eyeBlinkTimeArray = (getArrayFromByteStream(TrialTable_1.EyeBlinkTimeArray(i,:)));
eyeBlinkPercent = (getArrayFromByteStream(TrialTable_1.EyeBlinkPerc(i,:)))*100; %*100 to y values as percents

% time = linspace(TrialTable_1.StartEyeVid(i,1)-TrialTable_1.StartTrial(i,1),250*0.0052 + TrialTable_1.StartEyeVid(i,1)-TrialTable_1.StartTrial(i,1),250);
time = linspace(-(170-1)*0.0052,(250 - 170)*0.0052,250) ;

puffTime = 0; % in ms
xline(puffTime, '--m','LineWidth',3);
threshold = 20;
yline(threshold,'-.g'); % Eye Blink Threshold at 20%

CStime = -0.250;
% Find the indexes at cutoff point
cutoff = find(time >= CStime,1);

% Exlude the data points above the threshold at the CS time cutoff
if eyeBlinkPercent(cutoff)> threshold
    eyeBlinkPercent(cutoff(eyeBlinkPercent(cutoff)> threshold)) = NaN;

else
% Eyeclosure Percent at the puff time
time2 = time';
numspuffTime = find(time2 >= puffTime,1); % finds first index at or before 0 ms
idx1 = [idx1 numspuffTime];
idx = idx1';
eyePerc1 = [eyePerc1 eyeBlinkPercent(numspuffTime)];
eyePerc = eyePerc1';
puffTimeAtPerc1 = [puffTimeAtPerc1 time2(numspuffTime)];
puffTimeAtPerc = puffTimeAtPerc1';
% PercAtPuffTimeTable = cat(2, table(idx), table(eyePerc), table(puffTimeAtPerc));

nums = find(eyeBlinkPercent(time>-0.1) >= threshold,1); % finds first index at which threshold exceeded
diff = length(eyeBlinkPercent)-length(eyeBlinkPercent(time>-0.1));

indices1 = [indices1, nums+diff];
Indices = indices1';
eyePercent1 = [eyePercent1 eyeBlinkPercent(nums+diff)];
EyePercent = eyePercent1';
threshtimes1 = [threshtimes1, time(nums+diff)]; % eyeBlinkTimeArray(nums)-startTrial to get normalized values 
ThreshBlinkTimes = threshtimes1';
Threshold_Table1 = cat(2, table(Indices), table(EyePercent), table(ThreshBlinkTimes), ... 
    table(idx), table(eyePerc), table(puffTimeAtPerc)); %Table created for post thresh parameters 

title ("Mouse Blink Behavior (Trial Type 1)");
plot(time, eyeBlinkPercent, '-r', 'LineWidth', 2)
xline([CStime puffTime],'--') % xlabel = {'Light Time (CS)','Puff Time (US)'};
xlabel("Trial Time")
ylabel("Eye Closure Percentage")

end
end
hold off



figure
hold on
idx2 = [];
eyePerc2 = [];
puffTimeAtPerc2 = [];

threshtimes2 = [];
eyePercent2 = [];
indices2 = [];
for i=1:size(TrialTable_2)
eyeBlinkTimeArray = (getArrayFromByteStream(TrialTable_2.EyeBlinkTimeArray(i,:)));
eyeBlinkPercent = (getArrayFromByteStream(TrialTable_2.EyeBlinkPerc(i,:)))*100; %*100 to y values as percents

% time = linspace(TrialTable_2.StartEyeVid(i,1)-TrialTable_2.StartTrial(i,1),250*0.0052 + TrialTable_2.StartEyeVid(i,1)-TrialTable_2.StartTrial(i,1),250);
time = linspace(-(170-1)*0.0052,(250 - 170)*0.0052,250);

puffTime = 0; % in ms
xline(puffTime, '--m','LineWidth',3);
threshold = 20;
yline(threshold,'-.g'); % Eye Blink Threshold at 20%

CStime = -0.250;
% Find the indexes at cutoff point
cutoff = find(time >= CStime,1);

% Exlude the data points above the threshold at the CS time cutoff
if eyeBlinkPercent(cutoff)> threshold
    eyeBlinkPercent(cutoff(eyeBlinkPercent(cutoff)> threshold)) = NaN;

else

% Eyeclosure Percent at the puff time
time2 = time';
numspuffTime = find(time2 >= puffTime,1); % finds first index at or before 0 ms
idx2 = [idx2 numspuffTime];
idx = idx2';
eyePerc2 = [eyePerc2 eyeBlinkPercent(numspuffTime)];
eyePerc = eyePerc2';
puffTimeAtPerc2 = [puffTimeAtPerc2 time2(numspuffTime)];
puffTimeAtPerc = puffTimeAtPerc2';
% PercAtPuffTimeTable = cat(2, table(idx), table(eyePerc), table(puffTimeAtPerc));

nums = find(eyeBlinkPercent(time>-0.1) >= threshold,1); % finds first index at which threshold exceeded
diff = length(eyeBlinkPercent)-length(eyeBlinkPercent(time>-0.1));

indices2 = [indices2, nums+diff];
Indices = indices2';
eyePercent2 = [eyePercent2 eyeBlinkPercent(nums+diff)];
EyePercent = eyePercent2';
threshtimes2 = [threshtimes2, time(nums+diff)]; % eyeBlinkTimeArray(nums)-startTrial to get normalized values 
ThreshBlinkTimes = threshtimes2';
Threshold_Table2 = cat(2, table(Indices), table(EyePercent), table(ThreshBlinkTimes), ... 
    table(idx), table(eyePerc), table(puffTimeAtPerc)); %Table created for post thresh parameters 



title ("Mouse Blink Behavior (Trial Type 2)");
plot(time, eyeBlinkPercent, '-k', 'LineWidth', 2)
xline([CStime puffTime],'--') % xlabel = {'Light Time (CS)','Puff Time (US)'};
xlabel("Trial Time")
ylabel("Eye Closure Percentage")

end
end

hold off


% indices2 = [indices2, nums+diff];
% Indices = indices2';
% eyePercent2 = [eyePercent2 eyeBlinkPercent(nums+diff)];
% EyePercent = eyePercent2';
% threshtimes2 = [threshtimes2, eyeBlinkTimeArray(nums+diff)-TrialTable_2.StartTrial(i,1)]; % eyeBlinkTimeArray(nums)-startTrial to get normalized values 
% ThreshBlinkTimes = threshtimes2';
%-------------------------------------------------------------------------------------------------------------

