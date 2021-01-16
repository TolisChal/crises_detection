function [redu, redl, blueu, bluel] = indicator_mask_corners(X, band_ratio)

if nargin==1
    band_ratio=0.2;
end

[blue_mask, red_mask]=indicator_mask(X, band_ratio);

redu=triu(red_mask);
redl=tril(red_mask);

blueu=flip(tril(flip(blue_mask)));
bluel=flip(triu(flip(blue_mask)));