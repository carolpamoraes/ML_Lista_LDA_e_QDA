close all
clear all
clc


%Distribuição normal w1
x1 = [-1:.1:5];
y1 = normpdf(x1,2,1);

%Distribuição normal w2
x2 = [-4:0.1:8];
y2 = normpdf(x2,2,2);


plot(x1,y1)
hold on
plot(x2,y2)











