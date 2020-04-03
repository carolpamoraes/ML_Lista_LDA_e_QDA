close all
clear all
clc

simu=50;

Ac=0;

for it=1:simu

    %Distribuicao normal w1
    x1 = normrnd(2,1, 1, 500);
    etiqueta1=ones(1,500);

    %Distribuicao normal w2
    x2 = normrnd(2,2, 1, 500);
    etiqueta2=2*ones(1,500);


    %Dados organizados
    xTotal = [x1 x2];
    etiquetaTotal = [etiqueta1 etiqueta2];

    %Quantidade de dados
    total=1000;

    %Contadores
    cont_w1=0;
    cont_w2=0;
    acerto=0;
    erro=0;

    %Matriz de Confus�o
    dim=2;
    M_confu=zeros(dim,dim);



    %Classifica��o

    for passo_cl=1:total

        if (0.64<xTotal(1,passo_cl) && xTotal(1,passo_cl)<3.36)

            d_resultado(1,passo_cl)=1;


        else 

            d_resultado(1,passo_cl)=2;

        end



        if etiquetaTotal(1,passo_cl)==d_resultado(1,passo_cl)

            acerto=acerto+1;

                if d_resultado(1,passo_cl)==1

                    M_confu(1,1)=M_confu(1,1)+1;
                else
                    M_confu(2,2)=M_confu(2,2)+1;

                end

        else 

            erro=erro+1;       

                if d_resultado(1,passo_cl)==1

                    M_confu(1,2)=M_confu(1,2)+1;
                else
                    M_confu(2,1)=M_confu(2,1)+1;

                end

        end




    end


    

    %Acur�cia
    Ac=Ac+(acerto/total)*100;

end

Ac=Ac/simu

%Matriz Confusao
M_confu=confusionmat(etiquetaTotal,d_resultado);


        
        












