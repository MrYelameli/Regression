clc; clear all; close all;
%read the file
x=xlsread('labelled_brass_data.xlsx');
%seperate the indices given to each brass sample
index=x(:,1);
%take the transpose of the data
x_tran=x(:,2:end)';
%find the minimum value in that data
x_tran_min=min(x_tran);
%use repmat function for simplicity of subtraction
x_tran_min_repmat=repmat(x_tran_min,1024,1);
% "trapz" finds the area under the curve 
x_tran_trapz=trapz(x_tran);
% use repmat function for simplicity 
x_tran_trapz_repmat=repmat(x_tran_trapz,1024,1);
% to remove the dark noise subtract the signal by its minimum value and divide it by area under the signal 
dnr=(x_tran-x_tran_min_repmat)./(x_tran_trapz_repmat);
%take again transpose
dnr_tran=dnr';
%plot the histograms 
figure; histogram(dnr_tran); title('histogram plot of brass after removing dark noise ');
figure; histogram(x_tran'); title('histogram plot of brass original sigals');
%plot the signals to see the shape 
figure;plot(1:1024,x(1,2:end));title('LIBS raw singal plot of brass 1');
figure;plot(1:1024,dnr_tran(1,:));title('After removing dark noise of singal of brass 1');

% attach indices of each brass sample 
dnr_tran_index=[index dnr_tran];

%write a excel sheet on your computer
xlswrite('removed dark noise from brass.xlsx',dnr_tran_index);
