Raw data from ratings Experiments (1-3) are contained in folders named expX_data. For each user, these files contain a structure called dat with field:

dat.stimulus = 3 columns of stimulus information for each trial:
col1 = scene number
col2 = condition number (1. ZhangAverage, 2. ZhangGlobal, 3. ZhangLocal, 4. ZhangDichoptic, 5. ProperExpo, 6. LowExpo, 7. HighExpo, 8. DichopticExpo)
col3 = which eye sees which image (relevant for dichoptic conditions, 0 = LE global/RE local, LE low expo/RE high expo);

dat.resp  = rating response (1-5) for each trial

See "main.m" script for example analysis
