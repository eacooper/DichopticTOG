function [exp_low, exp_high] = dichoptic_exposures(originalHDR,low,high)
%
% This function takes in an HDR image file path, as well as gain factors for simulating low and high camera exposures as the input.
% It returns a pair of simulated low and high exposure 8 bit RGB images.
%
% This implements to simulated dichoptic exposure method described in
% ANONYMOUS
%
% Suggested Usage Example
% [exp_low, exp_high] = dichoptic_exposures('./image.hdr',0.03,4)

hdr     = hdrread(originalHDR); % load in HDR image file
hdr_adj = hdr./max(hdr(:));     % rescale and normalize the HDR image

% Generate simulated low exposure
exp_low = hdr_adj(:,:,:).*low;  % multiply by gain factor
exp_low = exp_low.^(0.45);      % apply gamma correction

exp_low(exp_low>1)=1;       % cap within 0 - 1 range
exp_low = exp_low.*255;     % scale to 0 - 255
exp_low = uint8(exp_low);   % convert to uint8 image

% Generate simulated high exposure
exp_high = hdr_adj(:,:,:).*high;    % multiply by gain factor
exp_high = exp_high.^(0.45);        % apply gamma correction

exp_high(exp_high>1)=1;     % cap within 0 - 1 range
exp_high = exp_high.*255;   % scale to 0 - 255
exp_high = uint8(exp_high); % convert to uint8 image

%Display the resulting images
figure(1);
subplot(1,2,1); hold on; title('low exposure');
imshow(exp_low);

subplot(1,2,2); hold on; title('high exposure');
imshow(exp_high);