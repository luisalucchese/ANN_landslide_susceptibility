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

function [ AUC,TPo,TNo,FPo,FNo,OTo,t_thresh,tam] = fnroccurve(T,S,cor)
% gera a curva ROC e calcula o AUC pelo método de integração trapezoidal
% AUC --> area embaixo da curva ROC
% TPo --> taxa de verdadeiro positivo para todos os limites
% TNo --> taxa de verdadeiro negativo para todos os limites
% FPo --> taxa de falso positivo para todos os limites
% FNo --> taxa de falso negativo para todos os limites
% OTo --> valor que sobra (deve ser zero)
% t_thresh --> valores utilizados de limites
% tam --> tamanho total da amostra
% T --> valores reais
% S --> valores estimados pelo modelo
% cor --> se cor é 0, o plot será preto. Se é 1, será vermelho. 
% se e 2, sera azul. Default: 0

% Author:
% Luisa Vieira Lucchese
% Date:
% 11.10.2018
%
% The licence that applies for this file is 
% Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
%

if nargin < 3
    cor=0;
end

Sdbl=S;
itmax=100;
step=1/itmax;
%threshold para curva ROC
tam=length(T);
for it=1:(itmax+1)
TP=0;
TN=0;
FP=0;
FN=0;
OT=0; %other
t=(step)*it -step; 
 for i=1:tam
    if T(i) >t && Sdbl(i)>t 
        TP=TP+1;
    elseif T(i)<t && Sdbl(i)<t
        TN=TN+1;
    elseif T(i)< t && Sdbl(i) >t
        FP=FP+1;
    elseif T(i) > t && Sdbl(i) <t
        FN=FN+1;
    else
        OT=OT+1;
    end
    
    if (TP+FN) == 0
        TPR(it)=0;
    else
        TPR(it)=TP/(TP+FN);
    end
    
    if (FP+TN) == 0
        FPR(it)=1;
    else
        FPR(it)=FP/(FP+TN);
    end
    TPo(it)=TP;
    TNo(it)=TN;
    FPo(it)=FP;
    FNo(it)=FN;
    OTo(it)=OT; %other
    t_thresh(it)=t;
 end
end
figure(100); grid on; hold on;
if (cor==0) plot(FPR,TPR,'-^k'); end
if (cor==1) plot(FPR,TPR,'-^r'); end
if (cor==2) plot(FPR,TPR,'-^b'); end
xlabel('FPR'); ylabel('TPR');
hold off;
 %tirando registros NaN
[j]=find(isnan(FPR)); FPR(j)=0;
[j]=find(isnan(TPR)); TPR(j)=0;
AUC=trapz(FPR,TPR); %valor negativo porque a variavel x é descrescente
AUC=-AUC;
end

