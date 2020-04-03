close all
clear all
clc



%numero de simulações
simu=50;
Media_M_confu=zeros(2,2);
dim=2;

for itsimu=1:simu


    load('dataset4.txt')

    %Média e Probabilidade de cada Classe
    %Classe w1
    W1=dataset4(1:100,:);
    mu_1=[mean(W1(:,1)) mean(W1(:,2))];
    Pw1=1/2;

    %Classe w2
    W2=dataset4(100:130,:);
    mu_2=[mean(W2(:,1)) mean(W2(:,2))];
    Pw2=1/2;

    %Contadores
    n=0;
    m=0;
    acerto=0;
    erro=0;

    %Quantidade de dados
    quant_training=85;
    quant_teste=45;
    total=130;

    %Inicialização
    Classe_1=zeros(2,3);
    Classe_2=zeros(2,3);


    sorteio=randperm(total);

    for passo_tr=1:quant_training

        %Dados Treinamento em MATRIZ
        d_training(passo_tr,:)=dataset4(sorteio(1,passo_tr),:);

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
        d_test(passo_t,:)=dataset4(sorteio_2(1,passo_t),:);

    end


    %Dados teste
    y_t=d_test(:,1);
    x_t=d_test(:,2);
    Teta_t=d_test(:,3);


    %Classificação

    for it_l=1:quant_teste


        %Função g1

        g1=-0.067659*d_test(it_l,1)^2-0.052149*d_test(it_l,2)^2-0.028198*d_test(it_l,1)*d_test(it_l,2)-0.022984*d_test(it_l,1)-0.0098848*d_test(it_l,2)-2.4238;


        %Função g2

        g2=-0.53702*d_test(it_l,1)^2-0.32129*d_test(it_l,2)^2+0.25047*d_test(it_l,1)*d_test(it_l,2)+0.12698*d_test(it_l,1)-0.088336*d_test(it_l,2)-1.7099;




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


