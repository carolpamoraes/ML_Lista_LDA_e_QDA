close all
clear all
clc


load('dataset5.txt')

%M�dia e Probabilidade de cada Classe
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

%Inicializa��o
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


%Classifica��o

for it_l=1:quant_teste
    
       
    %Fun��o g1    
    g1=0.032638*d_test(it_l,1)+2.3077*d_test(it_l,2)-3.4063;

    
    %Fun��o g2    
    g2=8.4517*d_test(it_l,1)+0.87589*d_test(it_l,2)-35.7812;

    
    %Fun��o g3  
    g3=-2.2121*d_test(it_l,1)+4.1563*d_test(it_l,2)-11.7757;

    
    
    
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

    disp('Classifica��o: 1');
    scatter(d_test(it_l,2),d_test(it_l,1),'^','blue');
    hold on

    elseif g2>g1&&g2>g3

    disp('Classifica��o: 2');
    scatter(d_test(it_l,2),d_test(it_l,1),'o','red');
    hold on
    
    else

    disp('Classifica��o: 3');
    scatter(d_test(it_l,2),d_test(it_l,1),'d','green');
    hold on

    end
    
      
       
end

%Acuracia
Ac=(acerto/quant_teste)*100;
 
 
%Matriz Confusao
M_confu_2=confusionmat(Teta_t,d_resultado);

% %Fronteira de decis�o 1
x_FD_1=[-6:7];
FD_1=5.88001*x_FD_1-22.6112;

% %Fronteira de decis�o 2
x_FD_2=[-6:7];
FD_2=3.25075*x_FD_2-7.31784;

% %Fronteira de decis�o 3
x_FD_3=[-6:7];
FD_3=1.21429*x_FD_3+4.52743;



scatter(mu_1(1,2),mu_1(1,1),'filled','black');
hold on
scatter(mu_2(1,2),mu_2(1,1),'filled','black');
hold on
scatter(mu_3(1,2),mu_3(1,1),'filled','black');
hold on
plot(x_FD_1,FD_1,'green');
hold on
plot(x_FD_2,FD_2,'green');
hold on
plot(x_FD_3,FD_3,'green');
hold off



