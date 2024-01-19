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

function O=fngerainicios(rep, nni, p, t)
    G=10*rep; D=zeros(G, G); O=cell(G, 4); o=cell(G, 4);
    for i=1:G, o(i, :)=fniniciais(nni, p, t); end
    for i=1:G, for j=1:G, D(i, j)=fndist(o(i, :), o(j, :)); end, end
    S=D+eye(G)*1000; for k=1:rep*5, [i, ~]=find(S==min(S(:)), 1); D(i, :)=0; end
    k=0;
    while k < rep
        [i, ~]=find(D==max(D(:)), 1); D(i, :)=0;
        k=k+1; O{k, 1}=o{i(1), 1}; O{k, 2}=o{i(1), 2}; O{k, 3}=o{i(1), 3}; O{k, 4}=o{i(1), 4};
    end
end