close all
clear all
clc


load('dataset2.txt')

%Média e Probabilidade de cada Classe
%Classe w1
W1=dataset2(1:15,:);
mu_1=[mean(W1(:,1)) mean(W1(:,2))];
Pw1=1/2;

%Classe w2
W2=dataset2(15:25,:);
mu_2=[mean(W2(:,1)) mean(W2(:,2))];
Pw2=1/2;

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
    
       
    % ||x-mu_1||
    
    d1=norm(d_test(it_l,1:2)-mu_1);
    
    % ||x-mu_2||
    
    d2=norm(d_test(it_l,1:2)-mu_2);
    
    
    
        if d1<d2

            d_resultado(it_l,1)=1;


        else 

            d_resultado(it_l,1)=2;

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

    if d1<d2

    disp('Classificação: 1');
    scatter(d_test(it_l,2),d_test(it_l,1),'^','blue');
    hold on

    else 

    disp('Classificação: 2');
    scatter(d_test(it_l,2),d_test(it_l,1),'o','red');
    hold on

    end
    
      
       
end

%Acuracia
Ac=(acerto/quant_teste)*100;
 
 
%Matriz Confusao
M_confu_2=confusionmat(Teta_t,d_resultado);

%x0 - Coeficiente linear
x0=0.5*(mu_1+mu_2)-(1/(norm(mu_1-mu_2)^2))*log(Pw1/Pw2)*(mu_1-mu_2);

%Coeficiente angular
W=(mu_1-mu_2);


% %Fronteira de decisão
x_FD=[-3:3];
FD=-2.68944*x_FD-0.692654;


scatter(mu_1(1,2),mu_1(1,1),'filled','black');
hold on
scatter(mu_2(1,2),mu_2(1,1),'filled','black');
hold on
scatter(x0(1,2),x0(1,1),'filled','black');
hold on
plot(x_FD,FD,'green');
hold off



