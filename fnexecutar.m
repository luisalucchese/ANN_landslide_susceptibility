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


function [ S ] = fnexecutar( rn,P )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
eesc=eval(rn.ent.esc); 
epar=rn.ent.par; 
ifat=eval(rn.int.fat); 
sfat=eval(rn.sai.fat); 
srec=eval(rn.sai.rec); 
spar=rn.sai.par;
wh=rn.int.sin(:,1:(end-1)); 
bh=rn.int.sin(:,end); 
ws=rn.sai.sin(:,1:(end-1)); 
bs=rn.sai.sin(:, end);
u=ones(1, size(P, 2)); 
p=eesc(P, epar, u); 
%whos p wh
h=ifat(wh*p+bh*u); 
s=sfat(ws*h+bs*u); 
S=srec(s, spar, u);
end

