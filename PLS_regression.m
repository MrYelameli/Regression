clc; clear all;
b=xlsread('Normalization of all rocks.xlsx'); % read the spectra file

%[~,score,~,~,e,m]=pca(a);

a=xlsread('X and Y.xlsx'); % read the zinc composition file. 


%seperate X and Y
X=b(1:7,2:end);   % this is spectra X size is 7x1024
y=a(1:7,7);       %this composition of zinc 1x7

[n,p]=size(X);

%Apply PLSREGRESS 
[Xloadings,Yloadings,Xscores,Yscores,betaPLS5,PLSPctVar]=plsregress(X,y,6);

figure;plot(1:6,cumsum(100*PLSPctVar(2,:)),'-bo');
xlabel('Number of PLS components');
ylabel('Percent Variance Explained in Y');


[Xloadings,Yloadings,Xscores,Yscores,betaPLS] = plsregress(X,y,6);
yfitPLS=[ones(n,1) X]*betaPLS;

% figure;
% plot(y,yfitPLS,'bo');
% xlabel('Observed Response');
% ylabel('Fitted Response');



%Calculate the rsquredPLS value
TSS = sum((y-mean(y)).^2);
RSS_PLS = sum((y-yfitPLS).^2);
rsquaredPLS = 1 - RSS_PLS/TSS


%Get the test data   
xtest=b(8:10,2:end);
ytest=a(8:10,7);

[m,q]=size(xtest);

%project the test data on the trained model. 
yTestfitPLS=[ones(m,1) xtest]*betaPLS;

figure;plot(ytest,yTestfitPLS,'bo');
xlabel('observed response')
ylabel('fitted response')

TSS_test=sum((ytest-mean(ytest)).^2);
RSS_PLS_test=sum((ytest-yTestfitPLS).^2);
rsquaredPLS_test=1-RSS_PLS_test/TSS_test
