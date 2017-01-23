clear all;
clc;
%read the file
x=xlsread('KOSAKA Rock10.xlsx');
%find the size of file
[m,~]=size(x);
%divide the train and test data
[trainInd,~,testInd] = dividerand(m,0.5,0,0.5);
r_test=x(testInd',:);
r_train=x(trainInd',:);

%find the size of train and test data
[p,~]=size(r_test);
[q,~]=size(r_train);

%generate the random 3000 samples of test data, whereas each sample is a
%sum of 10 samples.
test=zeros(3000,1024);

avg_sig=10;
indices=10*ones(3000,1);

for i=1:1:3000
    r=randi([1 p],avg_sig,1);
    test(i,:)=mean(r_test(r,:));
end
test=[indices test];
xlswrite('r10_test.xlsx',test);

%generate the random 3000 samples of test data, whereas each sample is a
%sum of 30 samples.

train=zeros(3000,1024);
for i=1:1:3000
    r=randi([1 q],avg_sig,1);
    train(i,:)=mean(r_train(r,:));
end
train=[indices train];
xlswrite('r10_train.xlsx',train);