% make barplot of overall and individual ratings as shown in Fig 4. Save the results in corresponding files (XXX_median.mat) for statistical analysis

% list of tasks
task = {'preference','detail','3d'};

% add paths to raw data
addpath('./exp1_data');
addpath('./exp2_data');
addpath('./exp3_data');

% get a listing of all data files
preferfiles     = dir(fullfile('./exp1_data/*.mat'));
prefernames     = {preferfiles.name};

detailfiles     = dir(fullfile('./exp2_data/*.mat'));
detailnames     = {detailfiles.name};

depthfiles      = dir(fullfile('./exp3_data/*.mat'));
depthnames      = {depthfiles.name};

% load individual data, separate out by conditions and calculate median per subject

% condition numbers at loading are:
% 1. Zhang Average
% 2. Zhang Global
% 3. Zhang Local
% 4. Zhang Dichoptic
% 5. Proper Expo
% 6. Low Expo
% 7. High Expo
% 8. Dichoptic Expo

% ordering of 6 & 7 will be switched when data are plotted/stored

% initialize matrices for data
all_median_detail = [];
all_median_prefer = [];
all_median_3d = [];

% for each task
for task_ind = [1 2 3] % preference, detail, 3d
    
    % get number of user files
    if task_ind==1
        count = size(prefernames,2);
    elseif task_ind==2
        count = size(detailnames,2);
    elseif task_ind==3
        count = size(depthnames,2);
    end
    
    
    % for each user
    for i = 1:count
        
        % initialize variables to store ratings
        zAVG        = [];   % 1. Zhang Average
        zGLOBAL     = [];   % 2. Zhang Global
        zLOCAL      = [];   % 3. Zhang Local
        zDICHOPTIC  = [];   % 4. Zhang Dichoptic
        
        PROPER      = [];   % 5. Proper Expo
        LOW         = [];   % 6. Low Expo
        HIGH        = [];   % 7. High Expo
        eDICHOPTIC  = [];   % 8. Dichoptic Expo
        
        % load the appropriate data for this task and grab user subject number
        if task_ind == 1
            load(['./exp1_data/' prefernames{i}]);
            subj = extractBefore(prefernames{i},'_');
        elseif task_ind ==2
            load(['./exp2_data/' detailnames{i}]);
            subj = extractBefore(detailnames{i},'_');
        elseif task_ind ==3
            load(['./exp3_data/' depthnames{i}]);
            subj = extractBefore(depthnames{i},'_');
        end
        
        % grab stimulus and response info
        stim = dat.stimulus;
        resp = dat.resp;
        data = [stim resp];
        
        data(data(:,4)==0,4)=3; % fixing up the response mistake where resp of 3 was recorded as a zero for some users
        
        % separate stimulus and response info out for each condition
        zAVG    = data(stim(:,2)==1,:);
        zGLOBAL   = data(stim(:,2)==2,:);
        zLOCAL   = data(stim(:,2)==3,:);
        zDICHOPTIC   = data(stim(:,2)==4,:);
        
        PROPER    = data(stim(:,2)==5,:);
        LOW    = data(stim(:,2)==6,:);
        HIGH    = data(stim(:,2)==7,:);
        eDICHOPTIC = data(stim(:,2)==8,:);
        
        % calculate user medians across all 18 images, each column is the median rating for a separate condition
        individual_resp = [median(zAVG(:,4)),median(zGLOBAL(:,4)),median(zLOCAL(:,4)),median(zDICHOPTIC(:,4)),median(PROPER(:,4)),median(HIGH(:,4)),median(LOW(:,4)),median(eDICHOPTIC(:,4)),str2num(subj)];
        
        % concatenate user data all together
        % each row is subj, each col is condition
        if task_ind == 1
            all_median_prefer(end+1,:)  = individual_resp;
        elseif task_ind ==2
            all_median_detail(end+1,:)  = individual_resp;
        elseif task_ind ==3
            all_median_3d(end+1,:)      = individual_resp;
        end
        
    end
    
    % unifying variable names for plotting
    if task_ind ==1
        all = all_median_prefer;
    elseif task_ind==2
        all = all_median_detail;
    elseif task_ind==3
        all = all_median_3d;
    end
    
    % labels for plots
    znames = {'Avg','Global','Local','zDichoptic'};
    enames = {'Proper','High','Low','eDichoptic'};
    
    %%%%%%%%%%%%%%zhang conditions %%%%%%%%%%%%%
    figure(1); hold on;
    cc = [1 2 3 4]; % conditions to plot
    subplot(1,3,task_ind);
    for barnum = [1 2 3 4]
        bar(barnum,median(all(:,cc(barnum))),'FaceColor',[0.5 0.2 0.75]);
        hold on;
        x = barnum-0.3:0.6/(size(all(:,cc(barnum)),1)-1):barnum+0.3;
        scatter(x',all(:,cc(barnum)),5,'k','filled');  % adding individual subject's median to bar plot
        p25 = prctile(all(:,cc(barnum)),25);
        p75 = prctile(all(:,cc(barnum)),75);
        plot([barnum barnum],[p25 p75],'k');
        hold on;
        
    end
    ylim([0.9 5.1]);
    yticks([1:1:5]);
    ylabel('Median Rating');
    title(task{task_ind});
    set(gca,'XTick',1:size(cc,2),'XTickLabel',znames,'FontSize',12);
    
    %%%%%%%%%%%%%%%%%%%%%EXPOSURE CONDITIONS%%%%%%%%%%%%%%%%
    figure(2); hold on;
    cc = [5 6 7 8]; % conditions to plot
    subplot(1,3,task_ind);
    for barnum = [1 2 3 4]
        bar(barnum,median(all(:,cc(barnum))),'FaceColor',[0.95 0.75 0]);
        hold on;
        x = barnum-0.3:0.6/(size(all(:,cc(barnum)),1)-1):barnum+0.3;
        scatter(x',all(:,cc(barnum)),5,'k','filled');  % adding individual subject's median to bar plot
        p25 = prctile(all(:,cc(barnum)),25);
        p75 = prctile(all(:,cc(barnum)),75);
        plot([barnum barnum],[p25 p75],'k');
        hold on;
    end
    ylim([0.9 5.1]);
    yticks([1:1:5]);
    ylabel('Median Rating');
    title(task{task_ind});
    set(gca,'XTick',1:size(cc,2),'XTickLabel',enames,'FontSize',12);
    
    %%%%%%%%%%%%%
    % save medians for each user
    % file format
    % cols = {'Avg','Global','Local','zDichoptic','Proper','High','Low','eDichoptic'};
    if task_ind==1
        savename = 'usermedians_preference.mat';
    elseif task_ind==2
        savename = 'usermedians_detail.mat';
    elseif task_ind==3
        savename = 'usermedians_depth.mat';
    end
    
    save(savename,'all');
end



