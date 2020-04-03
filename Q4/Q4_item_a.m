close all
clear all
clc


%Distribuição normal w1
x1 = [-1:0.0006060:5];
y1 = normpdf(x1,2,1);

%Distribuição normal w2
x2 = [2:0.06:8];
y2 = normpdf(x2,5,1);


plot(x1,y1)
hold on
plot(x2,y2)










