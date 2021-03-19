% split data into zhang et al tonemap conditions and exposure conditions and analyze them separately with general linear mixed model

% file paths and names of conditions
addpath('./exp6_data');
files       = dir(fullfile('./exp6_data/*.mat'));
filenames   = {files.name};
conds       = {'C1','C2','C3','C4','C5','C6','C7','C8'};    % condition order is: 'Avg','Global','Local','zDichoptic','Proper','Low','High','eDichoptic';
scenes      = {'S1','S2','S3','S4','S5','S6','S7','S8'};    % identifiers for 8 different scenes

% number of trials each subject runs
n_trials = 128;

% combine all participants data together

% initial matrix for all data
all = [];

% for each participant
for i = 1:size(filenames,2)
    
    % load their data
    load(filenames{i});
    
    % create matrix with subject number, stimulus, and response info
    % dat.stimulus: scene, patchrow, patchcol, highlow, cond, whicheye (see README)
    subj                = extractBefore(filenames{i},'_');
    current_subj        = zeros(n_trials,1);
    current_subj(:)     = str2num(subj);
    current_data        = [current_subj dat.stimulus dat.anskey dat.resp dat.anskey==dat.resp];
    
    % concatenate all subjects
    all = [all;current_data];
    
end

% format stimulus and response info and run GLME

% indices for Zhang method GLME and exposure method GLME
zhangIndex = find(all(:,6)<=4);
expoIndex = find(all(:,6)>=5);

% for each method
for i = 1:2
    
    % select appropriate indices
    if i == 1
        disp('running zhang fitting')
        r = zhangIndex;
    else
        disp('running exposure fitting')
        r = expoIndex;
    end
    
    % get info for fitting each trial
    Subject         = strcat('P',num2str(all(r,1)));    % subject number
    Scene           = strcat('S',num2str(all(r,2)));    % scene number
    Condition       = strcat('C',num2str(all(r,6)));    % condition number
    Correct         = all(r,10);                        % was response correct
    
    % set variables to categorical
    Scene = categorical(cellstr(Scene));
    Subject = categorical(cellstr(Subject));
    Condition = categorical(cellstr(Condition));
    
    % place variables into a table
    T = table(Subject,Scene,Condition,Correct);
    
    % run glme
    glme = fitglme(T,'Correct ~ 1 + Condition + (1|Scene) + (1|Subject)',... 
        'Distribution','Binomial','Link','logit','FitMethod','Laplace','DummyVarCoding','effects','Verbose',0);
    
    % examine glme results
    display(glme);
    
end



