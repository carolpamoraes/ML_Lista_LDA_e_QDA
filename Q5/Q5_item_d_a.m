close all
clear all
clc


%Distribuição normal w1
mu = [0 2];
sigma = [1 0; 0 1];
rng('default') 
W1 = mvnrnd(mu,sigma,500);
etiqueta1=ones(1,500);
mu_1=[0 2]';
covar_1=sigma;
Pw1=1/2;

%Distribuição normal w2
mu = [8 2];
sigma = [1 0; 0 1];
rng('default') 
W2 = mvnrnd(mu,sigma,500);
etiqueta2=2*ones(1,500);
mu_2=[8 2]';
covar_2=sigma;
Pw2=1/2;


%/wi
w1=(1/covar_1(1,1))*mu_1;
w2=(1/covar_2(1,1))*mu_2;


%wi0
w10=-0.5*(1/covar_1(1,1))*mu_1'*mu_1+log(Pw1);
w20=-0.5*(1/covar_2(1,1))*mu_2'*mu_2+log(Pw2);


%x0 - Coeficiente linear
x0=0.5*(mu_1+mu_2)-(covar_1(1,1)/(norm(mu_1-mu_2)^2))*log(Pw1/Pw2)*(mu_1-mu_2);

%Coeficiente angular
W=(mu_1-mu_2);

%Fronteira
x_FD=4*ones(1,17);
FD=(W(2,1)*x0(2,1)+W(1,1)*x0(1,1)-W(1,1)*x_FD)/W(2,1);
FD=[-4:12];



xTotal = [W1 ; W2];
etiquetaTotal = [etiqueta1' ; etiqueta2'];
dataset=[xTotal etiquetaTotal];


%Contadores
acerto=0;
erro=0;
n=0;
m=0;

%Quantidade de dados
quant_training=650;
quant_teste=350;
total=1000;


        sorteio=randperm(total)

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
    
       
            %Função g1
            g1=w1(1,1)*d_teste(it_l,1)+w1(2,1)*d_teste(it_l,2)+w10;

            %Função g2
            g2=w2(1,1)*d_teste(it_l,1)+w2(2,1)*d_teste(it_l,2)+w20;



        if g1>g2

            d_resultado(it_l,1)=1;
            scatter(d_teste(it_l,1),d_teste(it_l,2),'^','b')
            hold on
            


        else 

            d_resultado(it_l,1)=2;
            scatter(d_teste(it_l,1),d_teste(it_l,2),'o','red')
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





scatter(Classe_1(:,1),Classe_1(:,2),'+','b')
hold on
scatter(Classe_2(:,1),Classe_2(:,2),'+','r')
hold on
scatter(mu_1(1,1),mu_1(2,1),'filled','black');
hold on
scatter(mu_2(1,1),mu_2(2,1),'filled','black');
hold on
scatter(x0(1,1),x0(2,1),'filled','black');
hold on
plot(x_FD,FD,'green');
hold on
plot([mu_1(1,1) mu_2(1,1)], [mu_1(2,1) mu_2(2,1)],'black');
hold off










