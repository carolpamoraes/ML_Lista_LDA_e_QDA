close all
clear all
clc

simu=10;
Ac=0;
M_confu=zeros(2,2);

for it_it=1:simu

        load('dataset2.txt')

        %Quantidade de dados
        quant_training=20;
        quant_teste=5;
        total=25;
       
        %Contadores
        n=0;
        m=0;
        acerto=0;
        erro=0;
        
        sorteio=randperm(total)

        for passo_tr=1:quant_training

            %Dados Treinamento em MATRIZ
            d_training(passo_tr,:)=dataset2(sorteio(1,passo_tr),:);
            
            if d_training(passo_tr,3)==1
                
                n=n+1;
                
                W1(n,:)=d_training(passo_tr,:);
                
            else
                
                m=m+1;
                
                W2(m,:)=d_training(passo_tr,:);

            end
            
        end
        
        %Média e Probabilidade de cada Classe
        %Classe w1
        mu_1=[mean(W1(:,1)); mean(W1(:,2))];
        covar_1=cov(W1(:,1),W1(:,2));
        Pw1=n/quant_training;
        
        %Classe w2
        mu_2=[mean(W2(:,1)); mean(W2(:,2))];
        covar_2=cov(W2(:,1),W2(:,2));
        Pw2=m/quant_training;
                   
        %/wi
        w1=inv(covar_1)*mu_1;
        w2=inv(covar_2)*mu_2;


        %wi0
        w10=-0.5*mu_1'*inv(covar_1)*mu_1+log(Pw1);
        w20=-0.5*mu_2'*inv(covar_2)*mu_2+log(Pw2);
            
        
        %x0 - Coeficiente linear
        x0=0.5*(mu_1+mu_2)-(1/((mu_1-mu_2)'*inv((covar_1+covar_2)./2)'*(mu_1-mu_2)))*log(Pw1/Pw2)*(mu_1-mu_2)

        %Coeficiente angular
        W=inv((covar_1+covar_2)./2)*(mu_1-mu_2)
        
        %Fronteira
        x_FD=[-10:10];
        FD=(W(2,1)*x0(2,1)+W(1,1)*x0(1,1)-W(1,1)*x_FD)/W(2,1)



        figure(1)
        scatter(x0(1,1),x0(2,1),'filled','black');
        hold on
        plot(x_FD,FD,'green');
        hold on
        
        
        
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
            g1=w1(1,1)*d_test(it_l,1)+w1(2,1)*d_test(it_l,2)+w10;

            %Função g2

            g2=w2(1,1)*d_test(it_l,1)+w2(2,1)*d_test(it_l,2)+w20;



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
        
        
        
        %Acuracia
        Ac=Ac+(acerto/quant_teste)*100;


        %Matriz Confusao
        M_confu=M_confu+confusionmat(Teta_t,d_resultado);
        
        
        
        
    
        
end

%Acuracia média
Ac_media=Ac./simu;

%Matriz de confusão média
M_confu_media=M_confu./simu;



