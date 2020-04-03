close all
clear all
clc


%Distribuição normal w1
mu = [0 0];
sigma = [20 0; 0 1];
rng('default') 
W1 = mvnrnd(mu,sigma,1000);
etiqueta1=ones(1,1000);
P_w1=1/2;

%Distribuição normal w2
mu = [0 4];
sigma = [1 0; 0 1];
rng('default') 
W2 = mvnrnd(mu,sigma,1000);
etiqueta2=2*ones(1,1000);
P_w2=1/2;


xTotal = [W1 ; W2];
etiquetaTotal = [etiqueta1' ; etiqueta2'];
dataset=[xTotal etiquetaTotal];


%Dados
mu_1=[0 0];
mu_2=[0 4];

%Contadores
acerto=0;
erro=0;
n=0;
m=0;

%Quantidade de dados
quant_training=1300;
quant_teste=700;
total=2000;


sorteio=randperm(total);

        for passo_tr=1:quant_training

            %Dados Treinamento em MATRIZ
            d_training(passo_tr,:)=dataset(sorteio(1,passo_tr),:);
            
            if d_training(passo_tr,3)==1
                
                n=n+1;
                
                Classe_1(n,:)=d_training(passo_tr,:);
                
            else
                
                m=m+1;
                
                Classe_2(m,:)=d_training(passo_tr,:);

            end
            
        end



sorteio_2= sorteio(1,(quant_training+1):end);

        for passo_t=1:quant_teste

            %Dados Treinamento em MATRIZ
            d_teste(passo_t,:)=dataset(sorteio_2(1,passo_t),:);

        end


%Dados teste
y_t=d_teste(:,1);
x_t=d_teste(:,2);
Teta_t=d_teste(:,3);



%Classificação

for it_l=1:quant_teste
    
       
    % ||x-mu_1||
    
    d1=norm(d_teste(it_l,1:2)-mu_1);
    
    % ||x-mu_2||
    
    d2=norm(d_teste(it_l,1:2)-mu_2);
    
    
    
        if d1<d2

            d_resultado(it_l,1)=1;
            scatter(d_teste(it_l,1),d_teste(it_l,2),'^','b')
            hold on


        else 

            d_resultado(it_l,1)=2;
            scatter(d_teste(it_l,1),d_teste(it_l,2),'o','r')
            hold on

        end



        if d_teste(it_l,3)==d_resultado(it_l,1)

            acerto=acerto+1;

        else 

            erro=erro+1;       

        end
    
      
       
end

%Acuracia
Ac=(acerto/quant_teste)*100;
 
 
%Matriz Confusao
M_confu_2=confusionmat(d_teste(:,3),d_resultado);

%x0 - Coeficiente linear
x0=0.5*(mu_1+mu_2)-(1/(norm(mu_1-mu_2)^2))*log(1)*(mu_1-mu_2);

%Coeficiente angular
W=(mu_1-mu_2);


%Ponto mu classe 1
media_x1=mean(W1(:,1));
media_y1=mean(W1(:,2));

%Ponto mu classe 2
media_x2=mean(W2(:,1));
media_y2=mean(W2(:,2));


%Fronteira de decisão, para esse caso a fronteira será uma reta
%perpendicular a reta entre mu_1 e mu_2
xp=[-18:18];
yp=x0(1,2)*ones(1,37);


scatter(Classe_1(:,1),Classe_1(:,2),'+','b')
hold on
scatter(Classe_2(:,1),Classe_2(:,2),'+','r')
hold on
scatter(media_x1,media_y1,'filled','black');
hold on
scatter(media_x2,media_y2,'filled','black');
hold on
scatter(x0(1,1),x0(1,2),'filled','black');
hold on
plot(xp,yp,'black','LineWidth',[2]);
hold on
plot([media_x1 media_x2], [media_y1 media_y2],'black');
hold off










