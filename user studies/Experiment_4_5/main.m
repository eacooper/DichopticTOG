clear all; close all;

% generate summary results that can be used to make barplots and run statistics
preference_analysis;
detail_analysis;

% make barplot of overall proportions and individual user responses
make_plots;

% run t test to assess whether the proportions differ from chance
run_stats;

