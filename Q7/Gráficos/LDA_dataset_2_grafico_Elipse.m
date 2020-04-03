close all
clear all
clc


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
        p=0;
        q=0;
        acerto=0;
        erro=0;

        %Quantidade de dados
        quant_training=16;
        quant_teste=9;
        total=25;

        %Inicialização
        Classe_1=zeros(2,3);
        Classe_2=zeros(2,3);
        Resul_classe_1=zeros(2,3);
        Resul_classe_2=zeros(2,3);


        sorteio=randperm(total);

        for passo_m=1:total

            %Mistura dos dados
            d_mix(passo_m,:)=dataset2(sorteio(1,passo_m),:);

        end

        
        for passo_t=1:quant_teste
            
            va_t(passo_t,:)=randperm(total,1)
            %Dados Treinamento em MATRIZ
            d_test(passo_t,:)=dataset2(va_t(passo_t,:),:);

        end


        %Dados teste
        y_t=d_test(:,1);
        x_t=d_test(:,2);
        Teta_t=d_test(:,3);
        
        
        for passo_tr=1:quant_training

            %Mistura dos dados
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





            if g1>g2

            p=p+1;

            Result_classe_1(p,:)=d_test(it_l,:); 


            else 
                
            q=q+1;

            Result_classe_2(q,:)=d_test(it_l,:); 

            end
            
            x=dataset2(:,1);
            y=dataset2(:,2);
           %Gráfico Fronteira de decisão
           figure(1)
           ezplot('-0.30659*x^2+0.40347*x*y+2.00065*x-0.13105*y^2+0.743892*y+0.832523')
           hold on



        end

        %Acuracia
        Ac=(acerto/quant_teste)*100;


        %Matriz Confusao
        M_confu_2=confusionmat(Teta_t,d_resultado);

        %x0 - Coeficiente linear
        x0=0.5*(mu_1+mu_2)-(1/(norm(mu_1-mu_2)^2))*log(Pw1/Pw2)*(mu_1-mu_2);

        %Coeficiente angular
        W=(mu_1-mu_2);


        scatter(Classe_1(1,:),Classe_1(2,:),'+','blue');    
        hold on
        scatter(Classe_2(1,:),Classe_2(2,:),'+','red');
        hold on
        scatter(Result_classe_1(:,1),Result_classe_1(:,2),'^','blue');
        hold on
        scatter(Result_classe_2(:,1),Result_classe_2(:,2),'o','red');
        hold on
        scatter(x0(1,1),x0(1,2),'filled','black');
        hold off



