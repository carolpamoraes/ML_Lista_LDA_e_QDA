close all
clear all
clc


load('dataset6.txt')

%Média e Probabilidade de cada Classe
%Classe w1
d_W1=dataset6(1:50,:);
mu_1=[mean(d_W1(:,1)) mean(d_W1(:,2))];
covar_1=cov(d_W1(:,1),d_W1(:,2));
Pw1=1/3;

%Classe w2
d_W2=dataset6(51:100,:);
mu_2=[mean(d_W2(:,1)) mean(d_W2(:,2))];
covar_2=cov(d_W2(:,1),d_W2(:,2));
Pw2=1/3;

%Classe w3
d_W3=dataset6(101:150,:);
mu_3=[mean(d_W3(:,1)) mean(d_W3(:,2))];
covar_3=cov(d_W3(:,1),d_W3(:,2));
Pw3=1/3;

%/Wi
W1=-0.5*inv(covar_1);
W2=-0.5*inv(covar_2);
W3=-0.5*inv(covar_3);

%/wi
w1=inv(covar_1)*mu_1';
w2=inv(covar_2)*mu_2';
w3=inv(covar_3)*mu_3';

%wi0
w10=-0.5*mu_1*inv(covar_1)*mu_1'-0.5*log(det(covar_1))+log(Pw1);
w20=-0.5*mu_2*inv(covar_2)*mu_2'-0.5*log(det(covar_2))+log(Pw2);
w30=-0.5*mu_3*inv(covar_3)*mu_3'-0.5*log(det(covar_3))+log(Pw3);

disp(strcat('W1&',num2str(W1(1,1)),'*x^2',num2str(W1(2,2)),'*y^2',num2str(2*W1(1,2)),'*x*y',num2str(w1(1,1)),'*x',num2str(w1(2,1)),'*y',num2str(w10)));
disp(strcat('W2&',num2str(W2(1,1)),'*x^2',num2str(W2(2,2)),'*y^2',num2str(2*W2(1,2)),'*x*y',num2str(w2(1,1)),'*x',num2str(w2(2,1)),'*y',num2str(w20)));
disp(strcat('W3&',num2str(W3(1,1)),'*x^2',num2str(W3(2,2)),'*y^2',num2str(2*W3(1,2)),'*x*y',num2str(w3(1,1)),'*x',num2str(w3(2,1)),'*y',num2str(w30)));


disp(strcat('W1&',num2str(W1(1,1)),'*d_test(it_l,1)^2',num2str(W1(2,2)),'*d_test(it_l,2)^2',num2str(2*W1(1,2)),'*d_test(it_l,1)*d_test(it_l,2)',num2str(w1(1,1)),'*d_test(it_l,1)',num2str(w1(2,1)),'*d_test(it_l,2)',num2str(w10)));
disp(strcat('W2&',num2str(W2(1,1)),'*d_test(it_l,1)^2',num2str(W2(2,2)),'*d_test(it_l,2)^2',num2str(2*W2(1,2)),'*d_test(it_l,1)*d_test(it_l,2)',num2str(w2(1,1)),'*d_test(it_l,1)',num2str(w2(2,1)),'*d_test(it_l,2)',num2str(w20)));
disp(strcat('W3&',num2str(W3(1,1)),'*d_test(it_l,1)^2',num2str(W3(2,2)),'*d_test(it_l,2)^2',num2str(2*W3(1,2)),'*d_test(it_l,1)*d_test(it_l,2)',num2str(w3(1,1)),'*d_test(it_l,1)',num2str(w3(2,1)),'*d_test(it_l,2)',num2str(w30)));








