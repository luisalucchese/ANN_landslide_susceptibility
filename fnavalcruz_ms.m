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

function [ rn_sai, V, J,O] = fnavalcruz_ms(rn,Pt,Tt,Pa,Ta,ciclos,rep)
% [ rn_sai, V, J,O] = fnavalcruz_ms(rn,Pt,Tt,Pa,Ta,ciclos,rep)
% versao de multipla saida
% rn --> rede neural (de entrada e de saida)
% V --> struct que retorna do treinamento
% J --> numero do ciclo utilizado
% Pt --> amostra de treinamento, entradas
% Tt --> amostra de treinamento, saidas
% Pa --> amostra de ajuste, entradas
% Ta --> amostra de ajuste, saidas
% ciclos --> numero de ciclos
% rep --> repeticoes

tempo=clock;
    Vmin=9999;
    rn_sai=rn; nni=rn.int.num;
    O=fngerainicios(rep, nni, Pt, Tt);
    fai=eval(rn.int.fat); 
    dfai=eval(rn.int.der);
    fas=eval(rn.sai.fat); dfas=eval(rn.sai.der);
    eesc=eval(rn.ent.esc); epar=rn.ent.par; 
    sesc=eval(rn.sai.esc); spar=rn.sai.par;
    folga=10000; %folga para considerar que obteve o minimo
    ut=ones(1, size(Pt, 2)); pt=eesc(Pt, epar, ut); tt=sesc(Tt, spar, ut);
    ua=ones(1,size(Pa,2)); pa=eesc(Pa,epar,ua); ta=sesc(Ta,spar,ua);
    for r=1:rep
         fprintf('%s%d\n\n','% Treinando repeticao ', r)
         o=O(r, :);
         [RN, v, j] = fntreinafolga(o, rn, pt, tt, ut, pa, ta, ua, fai, dfai, fas, dfas,ciclos,folga);
         j
         %
         if v{2}(j) < Vmin, Vmin=v{2}(j); rn_sai=RN; V=v; J=j; end
         disp(v{2}(j)) %
    end %
end % fun

