close all
clear all
clc


%Distribuição normal w1
x1 = [-3:.1:3];
y1 = 0.5*normpdf(x1,0,1);

%Distribuição normal w2
x2 = [-1:.1:5];
y2 = 0.5*normpdf(x2,2,1);


plot(x1,y1)
hold on
plot(x2,y2)










