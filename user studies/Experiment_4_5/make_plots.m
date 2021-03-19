% plot 2AFC data on overall preference & detail visibility

% load concatentated data (each colum is a dichoptic/non-dichoptic comparison, each row is a participant
load('2afc_result_prefer.mat');

figure(); hold on;

% for each comparison
for cond = [1 2 3 4]
    
    % plot the mean across users
    bar(cond,mean(subjresult(:,cond)),'FaceColor',[0.95 0.75 0]);
    hold on;
    
    % plot individual subjects, jittered
    x = cond-0.3:0.6/(size(subjresult(:,cond),1)-1):cond+0.3;
    scatter(x',subjresult(:,cond),5,'k','filled');
    
    % add in 95% confidence interval
    minus_err = mean(subjresult(:,cond)) - 1.96 * (std(subjresult(:,cond))/sqrt(size(subjresult,1)));
    plus_err  = mean(subjresult(:,cond)) + 1.96 * (std(subjresult(:,cond))/sqrt(size(subjresult,1)));
    plot([cond cond],[minus_err plus_err],'k');
        
end

xlabels = {'Local','Low','C1','C2'};
ylim([0 1]);
yticks([0:0.25:1]);
ylabel('Dichoptic Preference');
title('Overall Preference');
set(gca,'XTick',1:4,'XTickLabel',xlabels,'FontSize',12);



% load concatentated data (each colum is a dichoptic/non-dichoptic comparison, each row is a participant
load('2afc_result_detail.mat');

figure(); hold on;

% for each comparison
for cond = [1 2 3 4]
    
    % plot the mean across users
    bar(cond,mean(subjresult(:,cond)),'FaceColor',[0.95 0.75 0]);
    hold on;
    
    % plot individual subjects, jittered
    x = cond-0.3:0.6/(size(subjresult(:,cond),1)-1):cond+0.3;
    scatter(x',subjresult(:,cond),5,'k','filled');
    
    % add in 95% confidence interval
    minus_err = mean(subjresult(:,cond)) - 1.96* (std(subjresult(:,cond))/sqrt(size(subjresult,1)));
    plus_err  = mean(subjresult(:,cond)) + 1.96* (std(subjresult(:,cond))/sqrt(size(subjresult,1)));
    plot([cond cond],[minus_err plus_err],'k');
    
end

xlabels = {'Local','Low','C1','C2'};
ylim([0 1]);
yticks([0:0.25:1]);
ylabel('Dichoptic Preference');
title('Detail Visibility');
set(gca,'XTick',1:4,'XTickLabel',xlabels,'FontSize',12);

