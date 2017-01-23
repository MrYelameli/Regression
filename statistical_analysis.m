
%% statistical analysis
%plotting histogram 
clc; close all; clear all;

tic
%read the train data
x=dlmread('train_data.txt');
train_data=x(:,2:end);
new_train_data=train_data;

%read the test data
y=dlmread('test_data.txt');
test_data=y(:,2:end);
new_test_data=test_data;

%plot the histgram of train_data
figure;histogram(train_data);

%plot the histogram of test data
figure; histogram(test_data);

%Find the skewness of each variable in train data 
train_skew=skewness(train_data);

%find the skewness of each variable in test data
test_skew=skewness(test_data);

%find the skewed variables in train data
train_skew_list= find(train_skew > 1.96 | train_skew < -1.96);

% find the skewed variables in test data
test_skew_list=find(test_skew > 1.96 | test_skew < -1.96);

%%% Data Transformation 
%It is observed that some of the variables of train and test dataset are  
%skewed so it is better to take log transformation. One of the techniques of 
% log transformation is power transormation i.e. boxcox function. 

[m,n]=size(train_skew_list);
[p,q]=size(test_skew_list);
[x,y]=size(train_data);

for i=1:1:n
    dat=train_data(:,train_skew_list(i));
    [trandat,~]=boxcox(dat);
    new_train_data(:,train_skew_list(i))=trandat;
end

for j=1:1:q
    dat=test_data(:,test_skew_list(j));
    [trandat,~]=boxcox(dat);
    new_test_data(:,test_skew_list(j))=trandat;
end

norm_new_train_data=featureNormalize(new_train_data); %featureNormalize is a function of normalization 
norm_new_test_data=featureNormalize(new_test_data);
figure; histogram(norm_new_train_data);
figure; histogram(norm_new_test_data);
toc





