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

function [nameload] = loadrightann(nome_inicial_rn,reg_treina1,reg_treina2,reg_treina3,reg_val,reg_test,nh)
%[nameload] = loadrightann(nome_inicial_rn,reg_treina1,reg_treina2,reg_treina3,reg_val,reg_test,nh)
%   nameload returns the name of the ann to load
    try
    inicialnome=strcat(nome_inicial_rn,reg_treina1,reg_treina2,reg_treina3,'_l_',reg_val,'_v_',reg_test,'_nh_');
    nameload=strcat(inicialnome,num2str(nh),'.mat');
    load(nameload);
    catch
        try
        inicialnome=strcat(nome_inicial_rn,reg_treina3,reg_treina2,reg_treina1,'_l_',reg_val,'_v_',reg_test,'_nh_');
        nameload=strcat(inicialnome,num2str(nh),'.mat');
        load(nameload);
        catch
            try
            inicialnome=strcat(nome_inicial_rn,reg_treina2,reg_treina3,reg_treina1,'_l_',reg_val,'_v_',reg_test,'_nh_');
            nameload=strcat(inicialnome,num2str(nh),'.mat');
            load(nameload);
            catch
                try
                inicialnome=strcat(nome_inicial_rn,reg_treina2,reg_treina1,reg_treina3,'_l_',reg_val,'_v_',reg_test,'_nh_');
                nameload=strcat(inicialnome,num2str(nh),'.mat');
                load(nameload);
                catch
                    try
                    inicialnome=strcat(nome_inicial_rn,reg_treina3,reg_treina1,reg_treina2,'_l_',reg_val,'_v_',reg_test,'_nh_');
                    nameload=strcat(inicialnome,num2str(nh),'.mat');
                    load(nameload);
                    catch
                        inicialnome=strcat(nome_inicial_rn,reg_treina1,reg_treina3,reg_treina2,'_l_',reg_val,'_v_',reg_test,'_nh_');
                        nameload=strcat(inicialnome,num2str(nh),'.mat');
                        load(nameload);
                    end
                end
            end
        end
    end
end