Raw data from detail performance Experiment (6) are contained in exp6_data folder. For each user, these files contain a structure called dat with fields:

dat.stimulus = 6 columns of stimulus information for each trial:

col1 	= scene number
col2,3  = pixel row and col indices for the top-left corner of the cued location
col4 	= highlight (4) or low-light (5) patch
col5    = condition (1. ZhangAverage, 2. ZhangGlobal, 3. ZhangLocal, 4. ZhangDichoptic, 5. ProperExpo, 6. LowExpo, 7. HighExpo, 8. DichopticExpo)
col6    = repeat number 1-2, which eye sees which image (1 = LE Global/RE Local, LE Low/RE High, vice versa for 2);

dat.anskey = whether correctly oriented (not mirror reversed) probe was presented first or second (1 or 2) for each trial
dat.resp  = response for each trial (participant picked the first or second probe was not mirror-reversed)


Visualizations of the image patches used in the experiment are contained in the patch_stimuli folder. Images are ordered as shown in Figure 7.
The first number of the image file indicate scene number and the second&third number indicate location

Parameters for locally tone mapped probe patch (left-most patch) for Exp. 6 using imadjust:

imadjust(patch0,[p_min p_max],outrange,gamma).*255

p_min = 2nd percentile of HDR image;
p_max = 98th percentile of HDR image;
gamma = 0.45;

if lowlight dominant patch: 
outrange = [0 0.6] for all scenes, except for scene3 outrange = [0 0 0; 0.525 0.6 0.6] for color correction

if highlight dominant patch:
outrange = [0.3 0.9];

See "main.m" for example analysis