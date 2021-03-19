% plot average performance on patch orientation judgement task

% file paths and names of conditions
addpath('./exp6_data');
files       = dir(fullfile('./exp6_data/*.mat'));
filenames   = {files.name};
znames      = {'Avg','Global','Local','zDichoptic'};
enames      = {'Proper','High','Low','eDichoptic'};


%initialize data matrix
% 24 people,
% 8 conditions
% 16 trials per condition
all_corr = NaN(24*16,8);

% for each participant
for f = 1:size(filenames,2)
    
    % load the data
    load(filenames{f});
    subj = str2num(extractBefore(filenames{f},'_'));
    
    %separate data by condition
    for cond = 1:8
        
        ind     = find(dat.stimulus(:,5)==cond); % condition indices
        correct = [dat.anskey(ind)==dat.resp(ind)]; % correct response?
        
        %each column is raw correct or incorrect, with particiants stacked 
        all_corr((f-1)*16 + 1:f*16,cond) = correct;
    end
end

% initialize vector for means and CIs
stat_result = [];

%use binofit to calculate confidence interval for each condition
for cond = [1 2 3 4 5 7 6 8] % switch ordering of High and Low exposure for plotting
    
    x           = sum(all_corr(:,cond));    % number of correct responses
    n           = size(all_corr,1);         % number of trials
    [phat,pci]  = binofit(x,n);             % proportion and 95% CI
    stat_result = [stat_result; phat,pci];  % each row is a condition (L,H exposure col already switched)
    
end

%plot bar plot with 95% confidence interval

% Zhang et al tone map conditions
zfig = figure(1);
for c = 1:4
    bar(c,stat_result(c,1),'FaceColor',[0.75 0.75 0.75]);
    hold on;
    x2 = ones(1,2)*(c);
    y2 = [stat_result(c,2:3)];
    plot(x2,y2,'k');
    hold on;
end
ylim([0.45,1]);
ylabel('Mean Proportion Correct');
title('Detail Visibility Performance: Zhang');
set(gca,'XTick',1:4,'XTickLabel',znames);
set(gca,'FontSize',12);

% Exposure conditions
efig = figure(2);
for c = 5:8
    bar(c-4,stat_result(c,1),'FaceColor',[0.75 0.75 0.75]);
    hold on;
    x2 = ones(1,2)*(c-4);
    y2 = [stat_result(c,2:3)];
    
    plot(x2,y2,'k');
    hold on;
end
ylim([0.45,1]);
ylabel('Mean Proportion Correct');
title('Detail Visibility Performance: Exposure');
set(gca,'XTick',1:4,'XTickLabel',enames);
set(gca,'FontSize',12);


