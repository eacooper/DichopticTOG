%run t-test on 2AFC data

% for each task
for task_ind = 0:1 % 0 = preference, 1 = detail
    
    % initialize results matrix
    result = [];
    
    % load data
    if task_ind == 0
        load('2afc_result_prefer.mat');
        disp('running t test for preference')
    else
        load('2afc_result_detail.mat');
        disp('running t test for detail')
    end
    
    % cols are conditions: Local,Low, C1, C2
    % calculate the average proportion dichoptic chosen across all subjects for the 4 conditions
    mean_prop = mean(subjresult,1);
    
    % run t-test for each comparison
    for cond = 1:4
        [h,p,ci,stat] = ttest(subjresult(:,cond),0.5);
        result = [result ; stat.tstat p]; % save results into matrix
    end
    
    % add average proportion to matrix to be displayed
    result = [mean_prop' result]; 
    disp('mean_value   t_test_stat  p')
    disp(result)
    
end



 