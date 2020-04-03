close all
clear all
clc

%Média e Probabilidade de cada Classe
%Classe w1
mu = [0 2];
sigma = [1 0.7; 0.7 3];
rng('default') 
d_W1 = mvnrnd(mu,sigma,500);
covar_1=[1 0.7; 0.7 3];
Pw1=1/2;

%Classe w1
mu = [8 2];
sigma = [1 0.7; 0.7 3];
rng('default') 
d_W2 = mvnrnd(mu,sigma,500);
covar_2=[1 0.7; 0.7 3];
Pw2=1/2;

%Dados
mu_1=[0 2];
mu_2=[8 2];

%/wi
w1=inv(covar_1)*mu_1';
w2=inv(covar_2)*mu_2';

%wi0
w10=-0.5*mu_1*inv(covar_1)*mu_1'+log(Pw1);
w20=-0.5*mu_2*inv(covar_2)*mu_2'+log(Pw2);





