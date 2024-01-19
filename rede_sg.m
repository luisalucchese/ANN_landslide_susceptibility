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

clear all %

%setando alguns parametros
%qual e a amostra de teste nesta rodada
reg_test='fao';
%qual e a amostra de validacao
reg_val='forr';
%quais sao as amostras de treinamento
reg_treina1='maq';
reg_treina2='rol';
reg_treina3='pres';
%quais sao as amostras de nao ocorrencia a utilizar. 1=sim
use_noc_alltime=1;
use_noc_event2=0; 
use_noc_place_oc_event2=0;
%local das tabelas
loctabelas='D:/Doutorado/Tese/SerraGeral_precipitacao/tabelas_amostras_apr2022/';
%lista dos atributos para selecionar (entradas e saidas)
lista_atr=[3:11 13:14]; 
lista_sai=[17];
temsusc=0; %1 se a lista inclui susc
lista=[lista_atr lista_sai];

quant_ent=length(lista_atr); %quantidade de entradas
quant_sai=length(lista_sai); %quantidade de saidas

col=3; 

%iniciamos com as amostras de ocorrencia
nomeler=strcat(loctabelas,reg_treina1,'_oc_trig.xlsx');
nomecsv=strcat(loctabelas,reg_treina1,'_oc_trig.csv');
plan=1;

Base=cell(13, 3); Base{1, 2}='Variables'; Base{1, 3}='Treino'; 

for i=1:20
    Base{i, 1}=i; 
end
limites=char('c', 't');
fprintf('%s\n\n', 'Reading variable names')
[~, nomes_outro]=xlsread(nomeler, plan, [deblank(limites(1, :)) int2str(1) ':' deblank(limites(2, :)) int2str(1)]);
for i=1:18
    Base{i+1, 2}=nomes_outro{1,i};%
end
[~, nomes2]=xlsread(nomeler, plan, [deblank('b') int2str(1)]);
Base(20,2)=nomes2;

csv=load(nomecsv);
fprintf('%s\n\n', 'csv file loaded')
%
csvaux(:,1:18)=csv(:,2:19); 
csvaux(:,19)=csv(:,1); 
clear csv;
csv=csvaux;
clear csvaux; 


nomecsv=strcat(loctabelas,reg_treina1,'_noc_trig_place_oc_event2.csv');
csv2=load(nomecsv);
fprintf('%s\n\n', 'csv file loaded')
csvaux(:,1:18)=csv2(:,2:19); 
csvaux(:,19)=csv2(:,1);
csv2=csvaux;
clear csvaux; 

for i=2:20
   Base{i, 3}=[Base{i, 3} (csv(:,i-1)'+csv2(:,i-1)')/2];
end

lentot_aux_1=length(csv(:,1));


%segunda amostra de treinamento

nomeler=strcat(loctabelas,reg_treina2,'_oc_trig.xlsx');
nomecsv=strcat(loctabelas,reg_treina2,'_oc_trig.csv');
csv=load(nomecsv);
fprintf('%s\n\n', 'csv file loaded')
csvaux(:,1:18)=csv(:,2:19); 
csvaux(:,19)=csv(:,1); 
clear csv;
csv=csvaux;
clear csvaux; 
% fazer a media com o segundo maior evento observado no local
nomecsv=strcat(loctabelas,reg_treina2,'_noc_trig_place_oc_event2.csv');
csv2=load(nomecsv);
fprintf('%s\n\n', 'csv file loaded')
csvaux(:,1:18)=csv2(:,2:19); 
csvaux(:,19)=csv2(:,1);
csv2=csvaux;
clear csvaux; 

for i=2:20
   Base{i, 3}=[Base{i, 3} (csv(:,i-1)'+csv2(:,i-1)')/2];
end

lentot_aux_2=length(csv(:,1));

%terceira amostra de treinamento

nomeler=strcat(loctabelas,reg_treina3,'_oc_trig.xlsx');
nomecsv=strcat(loctabelas,reg_treina3,'_oc_trig.csv');
csv=load(nomecsv);
fprintf('%s\n\n', 'csv file loaded')
csvaux(:,1:18)=csv(:,2:19); 
csvaux(:,19)=csv(:,1); 
clear csv;
csv=csvaux;
clear csvaux; 
% fazer a media com o segundo maior evento observado no local
nomecsv=strcat(loctabelas,reg_treina3,'_noc_trig_place_oc_event2.csv');
csv2=load(nomecsv);
fprintf('%s\n\n', 'csv file loaded')
csvaux(:,1:18)=csv2(:,2:19); 
csvaux(:,19)=csv2(:,1)+1; %amostras como ocorrencia 
csv2=csvaux;
clear csvaux; 

for i=2:20
   Base{i, 3}=[Base{i, 3} (csv(:,i-1)'+csv2(:,i-1)')/2];
end

lentot_aux_3=length(csv(:,1));

%amostra de validacao

%crio uma coluna na Base so para a validacao
%experimentando ter duas versoes da amostra de validacao - uma para
%treinar e outra para avaliar
%esta abaixo eh a para treinar
Base{1, 4}='Validacao';
nomeler=strcat(loctabelas,reg_val,'_oc_trig.xlsx');
nomecsv=strcat(loctabelas,reg_val,'_oc_trig.csv');
csv=load(nomecsv);
fprintf('%s\n\n', 'csv file loaded - ocorrencia validacao')
csvaux(:,1:18)=csv(:,2:19); 
csvaux(:,19)=csv(:,1); 
clear csv;
csv=csvaux;
clear csvaux; 
%fazer a media com o segundo maior evento observado no local
nomecsv=strcat(loctabelas,reg_val,'_noc_trig_place_oc_event2.csv');
csv2=load(nomecsv);
fprintf('%s\n\n', 'csv file loaded')
csvaux(:,1:18)=csv2(:,2:19); 
csvaux(:,19)=csv2(:,1); 
csv2=csvaux;
clear csvaux; 

for i=2:20
   Base{i, 4}=[Base{i, 4} (csv(:,i-1)'+csv2(:,i-1)')/2];
end

lentot_aux_val=length(csv(:,1));


%coluna para o teste
Base{1, 5}='Teste';
nomeler=strcat(loctabelas,reg_test,'_oc_trig.xlsx');
nomecsv=strcat(loctabelas,reg_test,'_oc_trig.csv');
csv=load(nomecsv);
fprintf('%s\n\n', 'csv file loaded - ocorrencia teste')
csvaux(:,1:18)=csv(:,2:19); 
csvaux(:,19)=csv(:,1); 
clear csv;
csv=csvaux;
clear csvaux; 
% fazer a media com o segundo maior evento observado no local
nomecsv=strcat(loctabelas,reg_test,'_noc_trig_place_oc_event2.csv');
csv2=load(nomecsv);
fprintf('%s\n\n', 'csv file loaded')
csvaux(:,1:18)=csv2(:,2:19); 
csvaux(:,19)=csv2(:,1);
csv2=csvaux;
clear csvaux; 

for i=2:20
   Base{i, 5}=[Base{i, 5} (csv(:,i-1)'+csv2(:,i-1)')/2];
end

lentot_aux_test=length(csv(:,1));

%agora complementamos com as de nao-ocorrencia
if use_noc_alltime==1 && use_noc_event2==0 && use_noc_place_oc_event2==0
    fprintf('opcao reformulada na v22')
    %primeira amostra de treinamento
    nomeler=strcat(loctabelas,reg_treina1,'_noc_trig_alltime.xlsx');
    nomecsv=strcat(loctabelas,reg_treina1,'_noc_trig_alltime.csv');
    csv=load(nomecsv);
    fprintf('%s\n\n', 'csv file loaded - noc alltime')
    csvaux(:,1:18)=csv(:,2:19); 
    csvaux(:,19)=csv(:,1); 
    clear csv;
    csv=csvaux;
    clear csvaux; 
    for i=2:20
        Base{i, 3}=[Base{i, 3} csv(:,i-1)'];
    end
    %segunda amostra de treinamento
    nomeler=strcat(loctabelas,reg_treina2,'_noc_trig_alltime.xlsx');
    nomecsv=strcat(loctabelas,reg_treina2,'_noc_trig_alltime.csv');
    csv=load(nomecsv);
    fprintf('%s\n\n', 'csv file loaded - noc alltime')
    csvaux(:,1:18)=csv(:,2:19); 
    csvaux(:,19)=csv(:,1); 
    clear csv;
    csv=csvaux;
    clear csvaux; 
    for i=2:20
        Base{i, 3}=[Base{i, 3} csv(:,i-1)'];
    end
    %terceira amostra de treinamento
    nomeler=strcat(loctabelas,reg_treina3,'_noc_trig_alltime.xlsx');
    nomecsv=strcat(loctabelas,reg_treina3,'_noc_trig_alltime.csv');
    csv=load(nomecsv);
    fprintf('%s\n\n', 'csv file loaded - noc alltime')
    csvaux(:,1:18)=csv(:,2:19); 
    csvaux(:,19)=csv(:,1); 
    clear csv;
    csv=csvaux;
    clear csvaux; 
    for i=2:20
        Base{i, 3}=[Base{i, 3} csv(:,i-1)'];
    end
    %amostra de validacao
    nomeler=strcat(loctabelas,reg_val,'_noc_trig_alltime.xlsx');
    nomecsv=strcat(loctabelas,reg_val,'_noc_trig_alltime.csv');
    csv=load(nomecsv);
    fprintf('%s\n\n', 'csv file loaded - noc alltime')
    csvaux(:,1:18)=csv(:,2:19); 
    csvaux(:,19)=csv(:,1); 
    clear csv;
    csv=csvaux;
    clear csvaux; 
    for i=2:20
        Base{i, 4}=[Base{i, 4} csv(:,i-1)'];
    end
    %amostra de teste
    nomeler=strcat(loctabelas,reg_test,'_noc_trig_alltime.xlsx');
    nomecsv=strcat(loctabelas,reg_test,'_noc_trig_alltime.csv');
    csv=load(nomecsv);
    fprintf('%s\n\n', 'csv file loaded - noc alltime')
    csvaux(:,1:18)=csv(:,2:19); 
    csvaux(:,19)=csv(:,1); 
    clear csv;
    csv=csvaux;
    clear csvaux; 
    for i=2:20
        Base{i, 5}=[Base{i, 5} csv(:,i-1)'];
    end
else
    print('este caso foi desativado');
end


length(Base{15,3})
length(Base{15,4})
length(Base{15,5})
load('L09_rn', 'rn');
tamanhovetor_treino=length(Base{2,3});
tamanhovetor_val=length(Base{2,4});
tamanhovetor_verif=length(Base{2,5});
nomes=strings();

for i=1:tamanhovetor_treino
   Base{7,3}(i)= real(log10(Base{7,3}(i)));
end
for i=1:tamanhovetor_val
   Base{7,4}(i)= real(log10(Base{7,4}(i)));
end
for i=1:tamanhovetor_verif
   Base{7,5}(i)= real(log10(Base{7,5}(i)));
end


for i=1:length(lista_atr)
   Pt(i,1:tamanhovetor_treino)=Base{lista_atr(i),3};
   Pl(i,1:tamanhovetor_val)=Base{lista_atr(i),4};
   Pv(i,1:tamanhovetor_verif)=Base{lista_atr(i),5};
   %
end
for i=1:length(lista_sai)
   Tt(i,1:tamanhovetor_treino)=Base{lista_sai(i),3};
   Tl(i,1:tamanhovetor_val)=Base{lista_sai(i),4};
   Tv(i,1:tamanhovetor_verif)=Base{lista_sai(i),5};
   %
end
for i=1:length(lista)
   tamanhonome=length(Base{lista(i),2});
   nomes(i)=num2str(Base{lista(i),2}(1:tamanhonome));
end
whos Pt
nomes

    

    Xe_tot=[NaN NaN;...
        0 360;...%aspect
        -1 1;... %aspect - sine
        -1 1;... %aspect - cosine
        min(Base{5,3}(:)) max(Base{5,3}(:));... %elev
        0 6;...%lnflo
        0 6;... %lsfac
        -0.1 0.1;... %planc
        -0.02 0.02;... %profc
        0 90; ... %slope
        min(Base{11,3}(:)) max(Base{11,3}(:));... %swi
        min(Base{12,3}(:)) max(Base{12,3}(:));... %twi
        min(Base{13,3}(:)) max(Base{13,3}(:));... %vdepth
        min(Base{14,3}(:)) max(Base{14,3}(:));... %vdcn
        0 max(Base{15,3}(:))*2;... %precday1
        0 max(Base{16,3}(:))*2;... %precday2
        0 max(Base{17,3}(:))*2;... %precday3
        0 max(Base{18,3}(:))*2;... %precday4
        0 max(Base{19,3}(:))*2;... %precday5
        0 1; ... %saida susc
        ];
    %
    Xe=Xe_tot(lista_atr,:);
    Xs=Xe_tot(lista_sai,:);%
%}


% Excluindo registros NaN
[~, j]=find(isnan(Pt)); Pt(:, j)=[]; Tt(:,j)=[];
[~, j]=find(Pt(:,:)==-9999); Pt(:, j)=[]; Tt(:,j)=[];

[~, j]=find(isnan(Pl)); Pl(:, j)=[]; Tl(:,j)=[];
[~, j]=find(Pl(:,:)==-9999); Pl(:, j)=[]; Tl(:,j)=[];

[~, j]=find(isnan(Pv)); Pv(:, j)=[]; Tv(:,j)=[];
[~, j]=find(Pv(:,:)==-9999); Pv(:, j)=[]; Tv(:,j)=[];


% ------------------------------------------------------------------------------------------------------------
% Separacao de entradas e de saidas:

%
quant=length(lista_atr);
%
clear enom
%
enom=nomes(1:length(lista_atr))
clear snom
%
snom=nomes((length(lista_atr)+1):(length(lista_atr)+length(lista_sai)))


% ------------------------------------------------------------------------------------------------------------
% Especificao da rede e dos parametros para o treinamento com repeticoes
nsai=length(lista_sai);
nhlist=[1 2 5 10 20 30 40];
for nhloop=1:length(nhlist)
nh=nhlist(nhloop); 
n=[quant nh nsai];
epar=[Xe(:, 1) Xe(:, 2)-Xe(:, 1)]; spar=[Xs(:, 1) Xs(:, 2)-Xs(:, 1)];
%
rn.ent.num=quant;
rn.ent.nom=enom;
rn.ent.par=epar;
rn.int.num=nh;
rn.int.sin=randn(quant+1,nh);
rn.sai.nom=snom;
rn.sai.par=spar;

ciclos=500000;%
rep=20;
% Treinamento do modelo 
[rn, V, J, O ] = fnavalcruz_ms(rn,Pt,Tt,Pl,Tl,ciclos,rep);

% Execucao, visualizacao e testes:
St=fnexecutar(rn, Pt); 
Sv=fnexecutar(rn, Pv);
Sl=fnexecutar(rn, Pl);

%estatisticas somente ocorrencia - teste
if nsai ==1 && temsusc==1 
else
cont_oc=0;
for i=1:size(Tv,2)
    if Base{20,5}(i)>0.5 %ou seja, ocorrencia
        cont_oc=cont_oc+1;
        Tvmeasure(1:(nsai-temsusc),cont_oc)=Tv(1:(nsai-temsusc),i);
        Svmeasure(1:(nsai-temsusc),cont_oc)=Sv(1:(nsai-temsusc),i);
    end
end
end


Tx=V{3};
figure(); plot(Tx);
Eq=V{1};
figure(); plot(Eq,'k'); hold on;
Ea=V{2}; plot(Ea,'b'); grid on;
legend('Eq','Ea');
set(gca, 'YScale', 'log');



[ AUC_t,TP,TN,FP,FN,OT,t_thresh,tam ] = fnroccurve(Tt(nsai,:),St(nsai,:),1);
[acuracia,t_otimo,it_otimo,acurac_t] = acharlimite(TP,TN,t_thresh,tam);

%com validacao normal
[ AUC_val,TP,TN,FP,FN,OT,t_thresh,tam ] = fnroccurve(Tl(nsai,:),Sl(nsai,:),1);
[acuracia,t_otimo_val,it_otimo_val,acurac_val] = acharlimite(TP,TN,t_thresh,tam);

%t_otimo_val
[ AUC_verif,TP,TN,FP,FN,OT,t_thresh,tam ] = fnroccurve(Tv(nsai,:),Sv(nsai,:),1);
[acuracia,t_otimo,it_otimo,acurac_verif] = acharlimite(TP,TN,t_thresh,tam);

[tpr,fpr]=roc(Tv(nsai,:),Sv(nsai,:));
AUC_verif_calc=trapz(fpr,tpr);


T=[Tt Tl Tv]; S=[St Sl Sv]; P=[Pt Pl Pv];
[ AUCglobal,TP,TN,FP,FN,OT,t_thresh,tam ] = fnroccurve(T(nsai,:),S(nsai,:),1);
[acuracia,t_otimo,it_otimo,accglobal] = acharlimite(TP,TN,t_thresh,tam);

clear RASTERS;
clear PIXELS;
clear A;


Base{1, 5}='Teste';
nomeler=strcat(loctabelas,reg_test,'_oc_trig.xlsx');
nomecsv=strcat(loctabelas,reg_test,'_oc_trig.csv');
csv=load(nomecsv);
fprintf('%s\n\n', 'csv file loaded - ocorrencia teste')
csvaux(:,1:16)=csv(:,3:18); 
csvaux(:,17)=csv(:,1); 
clear csv;
csv=csvaux;
clear csvaux; 
%noc trig place oc
nomecsv=strcat(loctabelas,reg_test,'_noc_trig_place_oc_event2.csv');
csv2=load(nomecsv);
fprintf('%s\n\n', 'csv file loaded - ocorrencia teste evento 2')
csvaux(:,1:16)=csv2(:,3:18); 
csvaux(:,17)=csv2(:,1); 
clear csv2;
csv2=csvaux;
clear csvaux; 
lenloop=length(csv2(:,1));

%will not be useful for susc only
if nsai ==1 && temsusc==1 
else
%original mea calculation
meaor(nhloop) = fncalcmea(Sl(1:(nsai-temsusc),:),Tl(1:(nsai-temsusc),:))

%filtering just occurrence
cont_oc=0;
for i=1:size(Tl,2)
    if Base{20,4}(i)>0.5 %ou seja, ocorrencia
        cont_oc=cont_oc+1;
        Tlmeasure(1:(nsai-temsusc),cont_oc)=Tl(1:(nsai-temsusc),i);
        Slmeasure(1:(nsai-temsusc),cont_oc)=Sl(1:(nsai-temsusc),i);
    end
end
mea(nhloop) = fncalcmea(Slmeasure,Tlmeasure)
end

namesave=strcat('rn_sg_',reg_treina1,reg_treina2,reg_treina3,'_l_',reg_val,'_v_',reg_test,'_nh_',num2str(nh));
save(namesave);

%
end


beep

alpha=0.1;
nome_inicial_rn='./rn_sg';
nhchosen=20;

if temsusc==1 
[nameload] = loadrightann(nome_inicial_rn,reg_treina1,reg_treina2,reg_treina3,reg_val,reg_test,nhchosen);
load(nameload);

[ AUC_t,TP,TN,FP,FN,OT,t_thresh,tam ] = fnroccurve(Tt(nsai,:),St(nsai,:),1);
[acuracia,t_otimo,it_otimo,acurac_t] = acharlimite(TP,TN,t_thresh,tam);

%com validacao normal
[ AUC_val,TP,TN,FP,FN,OT,t_thresh,tam ] = fnroccurve(Tl(nsai,:),Sl(nsai,:),1);
[acuracia,t_otimo_val,it_otimo_val,acurac_val] = acharlimite(TP,TN,t_thresh,tam);

%t_otimo_val

[ AUC_verif,TP,TN,FP,FN,OT,t_thresh,tam ] = fnroccurve(Tv(nsai,:),Sv(nsai,:),1);
[acuracia,t_otimo,it_otimo,acurac_verif] = acharlimite(TP,TN,t_thresh,tam);

[tpr,fpr]=roc(Tv(nsai,:),Sv(nsai,:));
AUC_verif_calc=trapz(fpr,tpr)
AUC_val
end