
close all
clear all
clc

%Distribuicao normal w1
x1 = normrnd(2,1, 1, 9900);
etiqueta1=ones(1,9900);

%Distribuicao normal w2
x2 = normrnd(5,1, 1, 100);
etiqueta2=2*ones(1,100);


%Dados organizados
xTotal = [x1 x2];
etiquetaTotal = [etiqueta1 etiqueta2];

%Quantidade de dados
total=10000;

%Contadores
cont_w1=0;
cont_w2=0;
acerto=0;
erro=0;



%Classificacao

for passo_cl=1:total
    
    if xTotal(1,passo_cl)<5.03
        
        d_resultado(1,passo_cl)=1;
        
       
    else 
        
        d_resultado(1,passo_cl)=2;
        
    end
    

    %Verificacao dos erros

    if etiquetaTotal(1,passo_cl)==d_resultado(1,passo_cl)

        acerto=acerto+1;
        
       
    else 

        erro=erro+1;    
        
        
    end


    
    
end


%Acuracia
Ac=(acerto/total)*100;
 
 
%Matriz Confusao
M_confu_2=confusionmat(etiquetaTotal,d_resultado);