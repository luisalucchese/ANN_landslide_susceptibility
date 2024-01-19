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

function [RN, V, J] = fntreinafolga(o, RN, pt, tt, ut, pa, ta, ua, fai, dfai, fas, dfas,ciclos,folga)
% folga --> numero de ciclos que devem ser "esperados" por um novo ponto de
% minimo
[wh, bh, ws, bs]=deal(o{:}); ht=fai(wh*pt+bh*ut); st=fas(ws*ht+bs*ut); et=(tt-st);
Eq=NaN(1,ciclos); Tx=NaN(1,ciclos); Eq(1)=sum(et(:).^2).*length(et); taxa=0.000001;
Tx(1)=taxa; mom=0.96; 
mo=mom; ciclo=1;
dwh=0.*wh; dbh=0.*bh; dws=0.*ws; dbs=0.*bs;
Ea=NaN(1, ciclos); Ea(1)=Eq(1); Ex=Eq(1);
J=1; 
wx=wh; bx=bh; %adicionado depois, para tentar consertar o problema da 
%indefinicao de wx e de bx
wy=ws; by=bs;
espaco=0;
    while (espaco < folga && ciclo < ciclos), ciclo=ciclo+1;
        [Wh, Bh, Ws, Bs]= fnatualiza(wh, bh, ws, bs, pt, ht, st, et, dfai, dfas, taxa, ut);
        Wh=Wh+mo*dwh;
        Bh=Bh+mo*dbh;
        Ws=Ws+mo*dws;
        Bs=Bs+mo*dbs;
        H=fai(Wh*pt+Bh*ut); S=fas(Ws*H+Bs*ut); E=tt - S;
        Eq(ciclo)=sqrt(sum(sum(E.^2))); Tx(ciclo)=taxa;
                if Eq(ciclo) > Eq(ciclo-1)
                    taxa= taxa*0.5;%
                    Eq(ciclo)= Eq(ciclo-1); mo=0;
                else
                    dwh=Wh-wh; dbh=Bh-bh; dws=Ws-ws; dbs=Bs-bs;
                    wh=Wh ; bh=Bh; ws=Ws; bs=Bs; mo=mom;
                    ht=H; st=S; et=E; %
                    taxa=taxa*1.1;
                end
        ea=ta-fas(ws*fai(wh*pa+bh*ua)+bs*ua); 
        Ea(ciclo)=sqrt(sum(sum(ea.^2)));
            if (Ea(ciclo) < Ex) 
                Ex=Ea(ciclo); 
                wx=wh; 
                bx=bh; 
                wy=ws; 
                by=bs; 
                J=ciclo; 
                espaco=0;
            else
                espaco=espaco+1;
            end
    end
    
RN.int.sin=[wx bx]; RN.sai.sin=[wy by];
Eq(1)=Eq(1)./length(et); Ea(1)=Ea(1)./length(et);
Eq(:, ciclo+1:end)=[]; Ea(:, ciclo+1:end)=[]; Tx(:, ciclo+1:end)=[]; V={Eq; Ea; Tx};
end % fim fntreinafolga





