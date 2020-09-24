tic

% add GIFT toolbox to path
addpath(genpath('/trdapps/linux-x86_64/matlab/toolboxes/GroupICATv4.0b/'))

% location of the reference/template spatial maps
ic_path = '/data/mialab/competition2019/NetworkTemplate/NetworkTemplate_High_VarNor.nii';

% location of the mask
mask_path = '/data/mialab/users/eswar/fbirn_p3/ICAresults_C100_fbirn/fbirnp3_restMask.nii';

% preprocessing option
% 1 - Remove mean per time point
% 2 - Remove mean per voxel
% 3 - Intensity normalization
% 4 - Variance normalization
preproc_type = 1;

% location of the preprocessed subject fMRI scan
subject_data = '/data/mialab/users/salman/projects/fBIRN/current/data/COBRE/cobre_5mm/sub_001/swa.nii';

disp(['Running GIG-ICA on ' subject_data])
[gigica_sm, gigica_tc] = run_gig_ica(subject_data, ic_path, mask_path, preproc_type);

toc