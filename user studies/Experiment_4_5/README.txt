Raw data from the 2AFC Experiments (4 & 5) are contained in folders named expX_data. For each user, these files contain a structure called dat with fields:

dat.stimulus = 3 columns of stimulus information for each trials:

col1 = condition number (1 = Zhang local vs Zhang dichoptic, 2 = Low exposure vs dichoptic exposure, 3 = Dice C1 vs Dice, 4 = Dice C2 vs Dice)
col2 = scene number
col3 = repeat number 1-4, which eye sees which image (odd = LE local/RE global, LE low expo/RE high expo, LE Dice C1/RE Dice C2, even = switched);

dat.order = whether dichoptic condition was presented first or second (1 or 2) for each trial
dat.resp = response for each trial (participant picked the first or second stimulus to be better)

See "main.m" for example analysis


