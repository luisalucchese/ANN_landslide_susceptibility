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

function [acuracia,t_otimo,it_otimo,acurac] = acharlimite(TP,TN,t_thresh,tam)
%[acuracia,t_otimo,it_otimo,acurac] = acharlimite(TP,TN,FP,FN,t_thresh,tam)
% acuracia: vetor com a acuracia para cada threshold
% t_otimo: melhor threshold
% it_otimo: indice do melhor threshold
% acurac: maior acuracia
% TP: taxa de verdadeiro positivo
% TN: taxa de verdadeiro negativo
% t_thresh: todos os limites usados
% tam: tamanho total da amostra
% 
%
% Author:
% Luisa Vieira Lucchese
% Date:
% 07.11.18
%
% The licence that applies for this file is 
% Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
% https://creativecommons.org/licenses/by-nc-sa/4.0/

certos=TP+TN;
todos=tam;
acuracia=certos./todos;
figure(20);
hold on; grid on;
plot(t_thresh, acuracia,'k');
[maximo, indice]=max(acuracia);
t_otimo=t_thresh(indice);
it_otimo=indice;
acurac=maximo;
end

