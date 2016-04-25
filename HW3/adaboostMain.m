
train_data = train_spam;
test_data = test_spam;
[trs, tcs] = size(test_data);
for i = 1:trs;
    if test_data(i,58) == 0
        test_data(i,58) = -1;
    end   
end


[rs,cs] = size(train_data); 
for i = 1:rs;
    if train_data(i,58) == 0
        train_data(i,58) = -1;
    end
    
    
end
params = hw3_train_adaboost(train_data,100);

for k = 1 : 100
error(k,1) = k;    
error(k,2) = hw3_test_adaboost(params,test_data,k);
end

display(error);