close all
clear all
clc


load('dataset5.txt')

%Média e Probabilidade de cada Classe
%Classe w1
W1=dataset5(1:50,:);
mu_1=[mean(W1(:,1)) mean(W1(:,2))];
Pw1=1/3;

%Classe w2
W2=dataset5(51:100,:);
mu_2=[mean(W2(:,1)) mean(W2(:,2))];
Pw2=1/3;

%Classe w3
W3=dataset5(101:150,:);
mu_3=[mean(W3(:,1)) mean(W3(:,2))];
Pw3=1/3;

%Contadores
n=0;
m=0;
p=0;
acerto=0;
erro=0;

%Quantidade de dados
quant_training=98;
quant_teste=52;
total=150;

%Inicialização
Classe_1=zeros(2,3);
Classe_2=zeros(2,3);
Classe_3=zeros(2,3);


sorteio=randperm(total);

for passo_tr=1:quant_training

    %Dados Treinamento em MATRIZ
    d_training(passo_tr,:)=dataset5(sorteio(1,passo_tr),:);

end

%Dados Treinamento
y=d_training(:,1);
x=d_training(:,2);
Teta_training= d_training(:,3);


for it=1:quant_training

    if Teta_training(it,1)==1

        n=n+1;

        Classe_1(:,n)=[x(it,1),y(it,1)];       

    elseif Teta_training(it,1)==2

        m=m+1;

        Classe_2(:,m)=[x(it,1),y(it,1)]; 
        
    else

        p=p+1;

        Classe_3(:,p)=[x(it,1),y(it,1)]; 

    end

end
        
        
sorteio_2= sorteio(1,(quant_training+1):end);

for passo_t=1:quant_teste

    %Dados Treinamento em MATRIZ
    d_test(passo_t,:)=dataset5(sorteio_2(1,passo_t),:);

end


%Dados teste
y_t=d_test(:,1);
x_t=d_test(:,2);
Teta_t=d_test(:,3);


%Classificação

for it_l=1:quant_teste
    
       
    %Função g1    
    g1=-0.56026*d_test(it_l,1)^2-0.57692*d_test(it_l,2)^2-0.016319*d_test(it_l,1)*d_test(it_l,2)+2.4245*d_test(it_l,1)+2.3035*d_test(it_l,2)-5.823;

    
    %Função g2    
    g2=-0.54372*d_test(it_l,1)^2-0.46687*d_test(it_l,2)^2+0.12395*d_test(it_l,1)*d_test(it_l,2)-1.8851*d_test(it_l,1)-1.7496*d_test(it_l,2)-4.8306;

    
    %Função g3  
    g3=-0.37905*d_test(it_l,1)^2-0.48813*d_test(it_l,2)^2+0.1331*d_test(it_l,1)*d_test(it_l,2)-2.2121*d_test(it_l,1)+4.1563*d_test(it_l,2)-11.9383;

    
    
    
    
        if g1>g2&&g1>g3

            d_resultado(it_l,1)=1;


        elseif g2>g1&&g2>g3

            d_resultado(it_l,1)=2;
            
        else

            d_resultado(it_l,1)=3;

        end



        if Teta_t(it_l,1)==d_resultado(it_l,1)

            acerto=acerto+1;

        else 

            erro=erro+1;       

        end
        
        
        
        
        
    %Grafico Teste
    figure(1)
    scatter(Classe_1(1,:),Classe_1(2,:),'+','blue');    
    hold on
    scatter(Classe_2(1,:),Classe_2(2,:),'+','red');
    hold on
    scatter(Classe_3(1,:),Classe_3(2,:),'+','green');
    hold on

    if g1>g2&&g1>g3

    disp('Classificação: 1');
    scatter(d_test(it_l,2),d_test(it_l,1),'^','blue');
    hold on

    elseif g2>g1&&g2>g3

    disp('Classificação: 2');
    scatter(d_test(it_l,2),d_test(it_l,1),'o','red');
    hold on
    
    else

    disp('Classificação: 3');
    scatter(d_test(it_l,2),d_test(it_l,1),'d','green');
    hold on

    end
    
      
       
end

%Acuracia
Ac=(acerto/quant_teste)*100;
 
 
%Matriz Confusao
M_confu_2=confusionmat(Teta_t,d_resultado);



scatter(mu_1(1,2),mu_1(1,1),'filled','black');
hold on
scatter(mu_2(1,2),mu_2(1,1),'filled','black');
hold on
scatter(mu_3(1,2),mu_3(1,1),'filled','black');
hold on
ezplot('-0.01654*x^2-0.140269*x*y+4.3096*x-0.11005*y^2+4.0531*y-0.9924')
hold on
%ezplot('-0.18121*x^2-0.149419*x*y+4.6366*x-0.08879*y^2-1.8528*y+6.1153')
hold on
ezplot('-0.16467*x^2-0.00915*x*y+0.327*x+0.02126*y^2-5.9059*y+7.1077')
hold off



