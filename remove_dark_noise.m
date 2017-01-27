clc; clear all; close all;
x=xlsread('labelled_brass_data.xlsx');
index=x(:,1);
x_tran=x(:,2:end)';
x_tran_min=min(x_tran);
x_tran_min_repmat=repmat(x_tran_min,1024,1);
x_tran_trapz=trapz(x_tran);
x_tran_trapz_repmat=repmat(x_tran_trapz,1024,1);
dnr=(x_tran-x_tran_min_repmat)./(x_tran_trapz_repmat);
dnr_tran=dnr';
figure; histogram(dnr_tran); title('histogram plot of brass after removing dark noise ');
figure; histogram(x_tran'); title('histogram plot of brass original sigals');
figure;plot(1:1024,x(1,2:end));title('LIBS raw singal plot of brass 1');
figure;plot(1:1024,dnr_tran(1,:));title('After removing dark noise of singal of brass 1');
dnr_tran_index=[index dnr_tran];

xlswrite('removed dark noise from brass.xlsx',dnr_tran_index);
