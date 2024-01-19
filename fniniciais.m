% ------------------------------------------------------------------------------------------------------------
% Oct 2022 - written by Luisa Lucchese
% Please cite our papers:
% Paper #1
% Lucchese et al. 2021
% Investigation of the influence of nonoccurrence sampling on landslide
% susceptibility assessment using Artificial Neural Networks
% Paper #2
% Lucchese et al. 2020
% Attribute selection using correlations and principal components for
% artificial neural networks employment for landslide 
% susceptibility assessment
% Paper #3
% Lucchese et al.
% Landslide susceptibility and spatially distributed antecedent rainfall 
% thresholds: a multiple-output Artificial Neural Network modeling approach
%
% The licence that applies for this code is 
% Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
% ------------------------------------------------------------------------------------------------------------

function o=fniniciais(nni, p, t)
    pmax=max(abs(p(:))); natr=size(p, 1); nsai=size(t, 1);
    wh=(rand(nni, natr).*2-1)./(natr*pmax); bh=(rand(nni, 1).*2-1)./(natr*pmax); 
    ws=(rand(nsai, nni).*2-1)./(nni*4); bs=(rand(nsai, 1).*2-1)./(nni*4);
    o{1, 1}=wh; o{1, 2}=bh; o{1, 3}=ws; o{1, 4}=bs;
end