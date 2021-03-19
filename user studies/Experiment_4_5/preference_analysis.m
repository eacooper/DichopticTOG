% concatenate 2AFC data on overall preference

% generate path to the data
addpath('./exp4_data/');
files = dir(fullfile('./exp4_data/','/*.mat'));
files = {files.name};

% for each user
for f = 1:size(files,2)
    
    % load the user data and grab stimulus/response information
    load(files{1,f});
    subj        = str2num(dat.subj);
    stim        = dat.stimulus;     % col1 = condition, col2 = scene, col3 = repeat
    bino_order  = dat.order(:,1);   % if 1, dichoptic presented 1st, if 2, dichoptic presented 2nd
    resp        = dat.resp;
    
    % separate out the conditions (col 1)
    % Local vs Zhang dichoptic (1)
    ind     = find(stim(:,1)==1);                           % indices for trials in this condition
    zhang   = [stim(ind,:) bino_order(ind,:) resp(ind,:)];  % concatenate just these trials
    zprop   = sum(zhang(:,4)==zhang(:,5))/size(zhang,1);    % calculate proportion of trials that the dichoptic was chosen
    
    % Low vs dichoptic exposure(2)
    ind     = find(stim(:,1)==2);
    expo    = [stim(ind,:) bino_order(ind,:) resp(ind,:)];
    eprop   = sum(expo(:,4)==expo(:,5))/size(expo,1);
    
    % C1 vs DiCE (3)
    ind     = find(stim(:,1)==3);
    dice1   = [stim(ind,:) bino_order(ind,:) resp(ind,:)];
    dprop1  = sum(dice1(:,4)==dice1(:,5))/size(dice1,1);
    
    % C2 vs DiCE (4)
    ind     = find(stim(:,1)==4);
    dice2   = [stim(ind,:) bino_order(ind,:) resp(ind,:)];
    dprop2  = sum(dice2(:,4)==dice2(:,5))/size(dice2,1);
    
    % store the proportion of trials on which the user picked the dichoptic condition for each of the 4 comparisons
    subjresult(f,:) = [zprop eprop dprop1 dprop2];
end

% save for analysis
save('2afc_result_prefer.mat','subjresult');
