close all
clear all
clc


load('dataset6.txt')

%Média e Probabilidade de cada Classe
%Classe w1
W1=dataset6(1:50,:);
mu_1=[mean(W1(:,1)) mean(W1(:,2))];
Pw1=1/3;

%Classe w2
W2=dataset6(51:100,:);
mu_2=[mean(W2(:,1)) mean(W2(:,2))];
Pw2=1/3;

%Classe w3
W3=dataset6(101:150,:);
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
    d_training(passo_tr,:)=dataset6(sorteio(1,passo_tr),:);

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
    d_test(passo_t,:)=dataset6(sorteio_2(1,passo_t),:);

end


%Dados teste
y_t=d_test(:,1);
x_t=d_test(:,2);
Teta_t=d_test(:,3);


%Classificação

for it_l=1:quant_teste
    
       
    %Função g1    
    g1=-0.51762*d_test(it_l,1)^2-0.57434*d_test(it_l,2)^2+0.14539*d_test(it_l,1)*d_test(it_l,2)+0.85238*d_test(it_l,1)+1.1954*d_test(it_l,2)-2.1384;

    
    %Função g2    
    g2=-0.35865*d_test(it_l,1)^2-0.47034*d_test(it_l,2)^2+0.011528*d_test(it_l,1)*d_test(it_l,2)-0.6527*d_test(it_l,1)-0.65134*d_test(it_l,2)-1.8252;

    
    %Função g3  
    g3=-0.49785*d_test(it_l,1)^2-0.5206*d_test(it_l,2)^2-0.12851*d_test(it_l,1)*d_test(it_l,2)-0.75026*d_test(it_l,1)+2.1367*d_test(it_l,2)-3.8056;
    
    
    
    
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
ezplot('-0.15897*x^2+0.133862*x*y+1.50508*x-0.104*y^2+1.84674*y-0.3132')
hold on
ezplot('-0.1392*x^2-0.140038*x*y-0.09756*x-0.05026*y^2+2.78804*y-1.9804')
hold on
%ezplot('0.01977*x^2-0.2739*x*y-1.60264*x+0.05374*y^2+0.9413*y-1.6672')
hold off



