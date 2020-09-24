% This snippet of code can be used to estimate spatial maps and timecourses from a single-subject 
% fMRI scan based on a reference template using the spatially constrained ICA or GIG-ICA algorithm.
% 
% Can be run in parallel on a large number of subjects or on a cluster and takes less than 2 minutes 
% per subject.
% 
% msalman@gsu.edu
% 2020-09-24

function [gigica_sm, gigica_tc] = run_gig_ica(subject_data, ic_path, mask_path, preproc_type)

    disp('loading mask')
    mask_ind = spm_read_vols( spm_vol( mask_path ) );
    mask_ind = find( mask_ind == 1 );

    disp('loading group level maps')
    icasig = niftiread( ic_path );
    icasig = reshape(icasig, [size(icasig,1)*size(icasig,2)*size(icasig,3) size(icasig,4)]);
    icasig = icasig( mask_ind, : );

    disp('z-scoring group-level maps')
    icasig = icatb_zscore(icasig);

    disp('loading data')
    data = icatb_read_data(subject_data, [], mask_ind);
    data = icatb_preproc_data(data, preproc_type);

    % todo check if size equal. if not, coregister.

    disp('running GIG-ICA')
    [gigica_sm, gigica_tc] = icatb_gigicar(data', icasig');
