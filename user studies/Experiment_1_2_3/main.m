clear all; close all;

% make barplot of overall and individual user ratings as shown in Fig 4. Save the results in corresponding files (XXX_median.mat) for statistical analysis
make_plots;

% run Friedman test and pairwise follow ups
run_stats;
