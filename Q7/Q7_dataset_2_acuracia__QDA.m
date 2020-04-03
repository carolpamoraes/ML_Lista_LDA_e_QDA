close all
clear all
clc


%numero de simulações
simu=50;
Media_M_confu=zeros(2,2);
dim=2;

for itsimu=1:simu


    load('dataset2.txt')

    %Média e Probabilidade de cada Classe
    %Classe w1
    W1=dataset2(1:15,:);
    mu_1=[mean(W1(:,1)) mean(W1(:,2))];
    Pw1=3/5;

    %Classe w2
    W2=dataset2(15:25,:);
    mu_2=[mean(W2(:,1)) mean(W2(:,2))];
    Pw2=2/5;

    %Contadores
    n=0;
    m=0;
    acerto=0;
    erro=0;

    %Quantidade de dados
    quant_training=16;
    quant_teste=9;
    total=25;

    %Inicialização
    Classe_1=zeros(2,3);
    Classe2=zeros(2,3);


    sorteio=randperm(total);

    for passo_tr=1:quant_training

        %Dados Treinamento em MATRIZ
        d_training(passo_tr,:)=dataset2(sorteio(1,passo_tr),:);

    end

    %Dados Treinamento
    y=d_training(:,1);
    x=d_training(:,2);
    Teta_training= d_training(:,3);


    for it=1:quant_training

        if Teta_training(it,1)==1

            n=n+1;

            Classe_1(:,n)=[x(it,1),y(it,1)];       

        else

            m=m+1;

            Classe_2(:,m)=[x(it,1),y(it,1)]; 

        end

    end


    sorteio_2= sorteio(1,(quant_training+1):end);

    for passo_t=1:quant_teste

        %Dados Treinamento em MATRIZ
        d_test(passo_t,:)=dataset2(sorteio_2(1,passo_t),:);

    end


    %Dados teste
    y_t=d_test(:,1);
    x_t=d_test(:,2);
    Teta_t=d_test(:,3);


    %Classificação

    for it_l=1:quant_teste


        %Função g1    
        g1=-1.0759*d_test(it_l,1)^2-0.90807*d_test(it_l,2)^2-0.17553*d_test(it_l,1)*d_test(it_l,2)+1.0138*d_test(it_l,1)+0.079282*d_test(it_l,2)-0.072077;

        %Função g2    
        g2=-0.76931*d_test(it_l,1)^2-0.77702*d_test(it_l,2)^2-0.579*d_test(it_l,1)*d_test(it_l,2)-0.98685*d_test(it_l,1)-0.66461*d_test(it_l,2)-0.9046;



            if g1>g2

                d_resultado(it_l,1)=1;


            else 

                d_resultado(it_l,1)=2;

            end



            if Teta_t(it_l,1)==d_resultado(it_l,1)

                acerto=acerto+1;

            else 

                erro=erro+1;       

            end
            
    end


         M_confu=confusionmat(Teta_t,d_resultado);

         Media_M_confu=Media_M_confu+confusionmat(Teta_t,d_resultado);
     

            
        prec_l=zeros(2,1);
        revoc_l=zeros(2,1);


        %Precisão
        for itd=1:dim    

            prec_l(dim,:)=M_confu(dim,dim)/sum(M_confu(dim,:));

        end


        % Precisão Média
        prec_media(itsimu,:)=sum(prec_l(:,1))/dim;



        %Revocação
        for itd=1:dim    

            revoc_l(:,dim)=M_confu(dim,dim)/sum(M_confu(:,dim));

        end


        %Revocação Média
        revoc_media(itsimu,:)=sum(revoc_l(1,:))/dim;



        %Acurácia
        Ac(itsimu,:)=(acerto/quant_teste)*100;

end

    %Média 
    M_prec= sum(prec_media)/simu;
    
    M_revoc= sum(revoc_media)/simu;
    
    M_Ac=sum(Ac)/simu;
    
    desvio_M_Ac=std(Ac);
    
    Media_M_confu=Media_M_confu./simu;  
    
    Z = ['Prec Média: ',num2str(M_prec)];
    disp(Z);

    Y = ['Revocação Média: ',num2str(M_revoc)];
    disp(Y);
 
    X = ['Acurácia Média: ',num2str(M_Ac),'%'];
    disp(X);
    
    W = ['Desvio Acurácia: ',num2str(desvio_M_Ac)];
    disp(W);
    
    Resultados=[M_Ac;desvio_M_Ac;M_prec;M_revoc];





